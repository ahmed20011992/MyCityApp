//
//  EventCardFrontView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//


import SwiftUI
import SwiftData


struct EventCardFrontView: View {
    @Query var savedEvents: [SavedEvent]
    @Environment(\.modelContext) var modelContext
    @Environment(\.scenePhase) var scenePhase
    
    @State var viewModel: EventViewModel
    let isFlipped: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(viewModel.event.title)
                .foregroundColor(.accentGold)
                .font(.headline)
            Text("Category: \(viewModel.event.category)")
                .foregroundColor(.white)
            
            if let formattedDate = viewModel.formattedDate {
                Text("On \(formattedDate), at \(viewModel.event.time)")
                    .foregroundColor(.white)
            }
        
            if viewModel.isNotificationScheduled {
                Text("event is scheduled now!")
                    .foregroundColor(.green)
            } else {
                Button("Schedule this Notification") {
                    Task {
                        await viewModel.scheduleNotification()
                        viewModel.saveEvent(context: modelContext, existingEvents: savedEvents)
                    }
                } .foregroundColor(viewModel.isAttendingEvent ? .green : .blue)
            }
            
            Button("Test Notification") {
                viewModel.testNotification()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorDark)
        .cornerRadius(10)
        .foregroundColor(.white)
        .task {
            viewModel.syncWithDatabase(savedEvents: savedEvents)
            await viewModel.scheduleNotificationIfNeeded()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    let authorized = await NotificationManager.checkAuthorization()
                    viewModel.updateReminderStatus(authorized: authorized)
                }
            }
        }
    }
}
