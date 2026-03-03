//
//  EventCollection.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//
import Foundation
import SwiftData

@Model
final class EventCollection: Identifiable {
    var name: String
    var timestamp: Date
    
    @Relationship(deleteRule: .nullify, inverse: \SavedEvent.collection)
    var events: [SavedEvent]?
    
    init(name: String, timestamp: Date = Date()) {
        self.name = name
        self.timestamp = timestamp
        self.events = []
    }
}

