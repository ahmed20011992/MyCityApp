//
//  Data.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import Foundation

struct AppData: Decodable {
    let events: [EventData]
    let hotels: [HotelData]
    let stores: [StoreData]
    let restaurants: [RestaurantData]
}

struct EventData: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let location: String
    var date: String?
    let time: String
    let image: String
    let category: String
    var attendeesCount: Int
    
    var usefulDateFormat: Date? {
        guard let dateString = date, !dateString.isEmpty else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateString)
    }

    var xx = Calendar.current.date(byAdding: .year, value: -1, to: .now)
}

struct HotelData: Decodable, Identifiable {
    let id: Int
    let name: String
    let location: String
    let price: String
    let availability: String?

    var isAvailable: Bool? {
        guard let availability = availability?.lowercased() else {
            return nil
        }
        return availability == "available"
    }
}

struct StoreData: Decodable, Identifiable {
    let id: Int
    let name: String
    let url: String?
    let district: String?
    let rating: Int?
}

struct RestaurantData: Decodable, Identifiable {
    let id: Int
    let place_name: String
    let food_category: String
    let name: String
}
