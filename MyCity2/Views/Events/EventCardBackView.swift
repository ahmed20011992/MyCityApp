//
//  EventCardBackView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//


import SwiftUI


struct EventCardBackView: View {
    let event: EventData
    
    var body: some View {
        VStack {
            Text(event.description)
                .foregroundColor(.white)
            Spacer()
            Text("Location: \(event.location)")
                .foregroundColor(.accentGold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorDark)
        .cornerRadius(10)
    }
}
