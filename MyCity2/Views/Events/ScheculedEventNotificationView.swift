//
//  ScheculedEventNotificationView.swift
//  MyCity2
//
// Created by ahmed elhasan on 2026-02-23.
//


import SwiftUI
import SwiftData

struct ScheculedEventNotificationView: View {
   
    @Environment(\.modelContext) var modelContext
    @Query(sort: \EventCollection.name) var collections: [EventCollection]
    @Query(sort: \SavedEvent.timestamp) var uncollectedEvents: [SavedEvent]
    
    @State private var newCollectionName = ""
    
    var looseEvents: [SavedEvent] {
        uncollectedEvents.filter { $0.collection == nil }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.colorLight, .colorDark], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    TextField("New Collection Name", text: $newCollectionName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                    
                    Button(action: addCollection) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentGold)
                    }
                    .disabled(newCollectionName.isEmpty)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding()

                List {
                    
                    ForEach(collections) { collection in
                        Section(header: Text(collection.name).foregroundColor(.accentGold).font(.headline)) {
                            if let events = collection.events, !events.isEmpty {
                                ForEach(events) { event in
                                    EventRow(event: event, collections: collections)
                                }
                            } else {
                                Text("No events in this collection")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .listRowBackground(Color.colorDark.opacity(0.5))
                        .swipeActions {
                            Button(role: .destructive) {
                                print("deleted collection")
                                modelContext.delete(collection)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    
                    if !looseEvents.isEmpty {
                        Section(header: Text("Unorganized").foregroundColor(.accentGold).font(.headline)) {
                            ForEach(looseEvents) { event in
                                EventRow(event: event, collections: collections)
                            }
                        }
                        .listRowBackground(Color.colorDark.opacity(0.5))
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Events & Collections")
    }
    
    private func addCollection() {
        let collection = EventCollection(name: newCollectionName)
        print("added collection")
        modelContext.insert(collection)
        newCollectionName = ""
    }
}


struct EventRow: View {
    let event: SavedEvent
    let collections: [EventCollection]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.body)
                    .fontWeight(.medium)
                Text(event.location)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            // ja g deleta om collection är unorganized
            
            if event.collection == nil && !collections.isEmpty {
                Menu {
                    ForEach(collections) { collection in
                        Button(collection.name) {
                            print("added event to folder")
                            event.collection = collection
                        }
                    }
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .foregroundColor(.blue)
                }
            }

            Button(role: .destructive) {
                print("deleted event")
                modelContext.delete(event)
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ScheculedEventNotificationView()
}
