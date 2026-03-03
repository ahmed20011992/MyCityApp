//
//  EventViewModel.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//
import Foundation
import Observation
import SwiftData
import SwiftUI

@Observable
class EventViewModel {
    var event: EventData
    var isNotificationScheduled: Bool = false
    var isAttendingEvent: Bool = false
    var gettingReminder: Bool = false
    
    init(event: EventData) {
        self.event = event
    }
    
    var formattedDate: String? { // värför har jag den alltid och vad den gör här ??
        guard let newDate = event.usefulDateFormat else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: newDate)
    }
    
    func scheduleNotificationIfNeeded() async {
        guard let eventDate = event.usefulDateFormat else {
            return
        }
        
        let notificationDate = Calendar.current.date(byAdding: .day, value: -1, to: eventDate)
        
        if let notificationDate = notificationDate {
            let timeInterval = notificationDate.timeIntervalSinceNow
            if gettingReminder {
                NotificationManager.scheduleNotification(seconds: timeInterval, title: event.title, body: "Do not miss your event: \(event.description)")
            }
        }
    }
    
    func scheduleNotification() async {
        await scheduleNotificationIfNeeded()
        isNotificationScheduled = true
        isAttendingEvent = true
    }
    
    func testNotification() {
        let testTimeInterval: TimeInterval = 5
        NotificationManager.scheduleNotification(seconds: testTimeInterval, title: event.title, body: "Do not miss this event: \(event.description).")
    }
    
    func saveEvent(context: ModelContext, existingEvents: [SavedEvent], collection: EventCollection? = nil) {
        guard let eventDate = event.usefulDateFormat else {
            return
        }
// här menar jag Hitta det första eventet som har exakt samma titel som det vi försöker spara just nu.
        let existingEvent = existingEvents.first(where: { $0.title == event.title })
// så om den redan finns sparar vi det gamla men om den inte finns sparar vi den då
        if existingEvent == nil {
            let dataEvent = SavedEvent(
                title: event.title,
                eventDescription: event.description,
                location: event.location,
                image: event.image,
                date: event.date,
                timestamp: eventDate,
                theEventIsScheduled: true
            )
            dataEvent.collection = collection // mitt pugg här utan denna line hade jag löst evneter utan katogirer in swift data så..
            context.insert(dataEvent)
            print("saved event")
        }
    }
    // detta ska användas sen i cardfrontview och den bara ändra status av
    func updateReminderStatus(authorized: Bool) {
        //gettingReminder = !authorized
        gettingReminder = authorized
    }
    
    func syncWithDatabase(savedEvents: [SavedEvent]) {
        if savedEvents.contains(where: { $0.title == event.title }) {
            isAttendingEvent = true
            isNotificationScheduled = true
            print("found saved event, making it green")
        }
    } // här fixade jag buggen när appen glömmar saker som sparades i swiftdata och ui "Den här funktionen "synkar" (matchar) det som syns på skärmen med det som finns i din SwiftDatadatabas. när appen är avstängd"
}
