//
//  RestaurantsModel.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
class RestaurantsViewModel {
    
    var restaurants: [RestaurantData] = []
    var isLoading = false
    var errorMessage: String?
    
    private let baseUrl = "https://ahmed20011992.github.io/events-API/db.json"
    
    func loadRestaurants() async {
        guard let url = URL(string: baseUrl) else { return }
        
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let appData = try JSONDecoder().decode(AppData.self, from: data)
            self.restaurants = appData.restaurants
            self.errorMessage = nil
            print("Successfully fetched \(restaurants.count) restaurants.")
        } catch let error as DecodingError {
            handleDecodingError(error)
        } catch {
            self.errorMessage = "Failed to load restaurants: \(error.localizedDescription)"
            print("General error loading restaurants: \(error)")
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
}
