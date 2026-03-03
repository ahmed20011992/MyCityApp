//
//  FlippableEventCardView.swift
//  MyCity2
//
// Created by ahmed elhasan on 2026-02-23.
//


import SwiftUI


struct FlippableEventCardView: View {
    let event: EventData
    @State private var isFlipped = false
    
    var body: some View {
        ZStack {
            EventCardFrontView(viewModel: EventViewModel(event: event), isFlipped: isFlipped)

                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 0 : 1)
            
            EventCardBackView(event: event)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 1 : 0)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                isFlipped.toggle()
            }
        }
    }
}
