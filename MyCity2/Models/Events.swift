//
//  Events.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//
import Foundation
import SwiftData

@Model
final class SavedEvent: Identifiable {
    @Attribute(.unique) var id: String
    var title: String
    var eventDescription: String
    var location: String
    var image: String
    var date: String?
    var timestamp: Date
    var theEventIsScheduled: Bool
    var collection: EventCollection?
    
    init(id: String = UUID().uuidString, title: String, eventDescription: String, location: String, image: String, date: String?, timestamp: Date = Date(), theEventIsScheduled: Bool = false) {
        self.id = id
        self.title = title
        self.eventDescription = eventDescription
        self.location = location
        self.image = image
        self.date = date
        self.timestamp = timestamp
        self.theEventIsScheduled = theEventIsScheduled
    }
}

