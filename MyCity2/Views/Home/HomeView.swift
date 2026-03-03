//
//  HomeView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorLight
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        NavigationLink(destination: MenuView()) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Text("Jönköping")
                            .foregroundStyle(Color.white)
                            .font(.title)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        NavigationLink(destination: ScheculedEventNotificationView()) {
                            Image(systemName: "bell")
                                .foregroundColor(Color.white)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    ScrollView {
                        VStack(spacing: 2) {
                            Image("jonkoping")
                                .resizable()
                                .scaledToFit()
                            
                            Image("jonkoping")
                                .resizable()
                                .scaledToFit()
                            
                            HStack(spacing: 2) {
                                Image("jonkoping")
                                    .resizable()
                                    .scaledToFit()
                                Image("jonkoping")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            Image("jonkoping")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
        }
    }
}
