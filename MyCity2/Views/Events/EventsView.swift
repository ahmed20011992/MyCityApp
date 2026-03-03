//
//  EventsView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//


import SwiftUI


struct EventsView: View {
    @State private var viewModel = EventsViewModel()
    //@State private var gettingReminder = false
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
                Color.colorLight
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title3)
                                .padding(10)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Text("Events")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Color.clear.frame(width: 40, height: 40)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    ScrollView {
                        HStack(spacing: 20) {
                            Text("Coming events in Jönköping")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            Spacer()
                            
                            NavigationLink(destination: ScheculedEventNotificationView()) {
                                Image(systemName: "bell")
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        VStack {
                            ForEach(viewModel.events) { event in
                                FlippableEventCardView(event: event)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .task {
                await viewModel.loadEvents()
          //      let authorized = await NotificationManager.checkAuthorization()
       //         gettingReminder = !authorized
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    Task {
                       // let authorized = await NotificationManager.checkAuthorization()
                      //  gettingReminder = !authorized
                    }
                }
            }
    }
}
