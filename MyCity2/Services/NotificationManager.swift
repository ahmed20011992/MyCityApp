//
//  NotificationManager.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//
import Foundation
import UserNotifications

class NotificationManager {
    
    static func checkAuthorization() async -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        let settings = await notificationCenter.notificationSettings()
        
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        case .notDetermined:
            do {
                return try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
            } catch {
                print("Authorization request failed: \(error)")
                return false
            }
        default:
            return false
        }
    }
    
    static func scheduleNotification(seconds: TimeInterval, title: String, body: String)  {
        let notificationCenter = UNUserNotificationCenter.current()
        
        // kolla om det finns tidigara notifina´cation och ta bort dem om det behövs
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "EventNotification", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully for \(seconds) seconds from now.")
            }
        }
    }
}
