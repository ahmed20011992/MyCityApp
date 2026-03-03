//
//  HotelsModel.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//
import Foundation
import Observation
import SwiftData

@MainActor
@Observable
class HotelsViewModel {
    
    var hotels: [HotelData] = []
    var isLoading = false
    var errorMessage: String?
    
    private let baseUrl = "https://ahmed20011992.github.io/events-API/db.json"
    
    func loadHotels() async {
        guard let url = URL(string: baseUrl) else { return }
        
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let appData = try JSONDecoder().decode(AppData.self, from: data)
            self.hotels = appData.hotels
            self.errorMessage = nil
            print("Successfully fetched \(hotels.count) hotels.")
        } catch let error as DecodingError {
            handleDecodingError(error)
        } catch {
            self.errorMessage = "Failed to load hotels: \(error.localizedDescription)"
            print("General error loading hotels: \(error)")
        }
        isLoading = false
    }

    private func handleDecodingError(_ error: DecodingError) {
        let message: String
        switch error {
        case .typeMismatch(let type, let context):
            message = "Type mismatch: \(type) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .valueNotFound(let value, let context):
            message = "Value not found: \(value) at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .keyNotFound(let key, let context):
            message = "Key not found: '\(key.stringValue)' at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        case .dataCorrupted(let context):
            message = "Data corrupted at \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"
        @unknown default:
            message = "Unknown decoding error"
        }
        self.errorMessage = "Data format error: \(message)"
        print("Decoding error: \(message)")
    }
    
    var bookingURL: URL {
        URL(string: "https://www.booking.com/searchresults.en-gb.html?label=jonkoping-2kpWkpembvZar3LMkb8DoAS153064796560%3Apl%3Ata%3Ap120%3Ap2%3Aac%3Aap%3Aneg%3Afi%3Atikwd-5161847841%3Alp9062426%3Ali%3Adec%3Adm%3Appccp%3DUmFuZG9tSVYkc2RlIyh9Yf5EcukO1MOGLSSAuId8ToA&gclid=CjwKCAiAxaCvBhBaEiwAvsLmWIM_mNhKVsiEVCG5sAo-Kve9QdbczJHju1NNLbX12FbLyRFRvmKrohoCPbIQAvD_BwE&aid=303948&city=-2492129")!
    }
}
