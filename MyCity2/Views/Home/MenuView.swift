//
//  MenuView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
            ZStack{
                Color.colorLight
                    .ignoresSafeArea()
                ScrollView{
                    Spacer(minLength: 200)
                    VStack(spacing:20){
                        NavigationLink(destination: EventsView()) {
                            HStack {
                                Text("Events")
                                Image(systemName: "calendar.badge.clock")
                            }
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.colorDark)
                            .cornerRadius(15)
                        }

                        NavigationLink(destination: StoresView()) {
                            HStack {
                                Text("Stores")
                                Image(systemName: "cart")
                            }
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.colorDark)
                            .cornerRadius(15)
                        }
                        NavigationLink(destination: HotelListView()) {
                            HStack {
                                Text("Hotels")
                                Image(systemName: "bed.double")
                            }
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.colorDark)
                            .cornerRadius(15)
                        }
                        
                        NavigationLink(destination: RestaurantsView()) {
                            HStack {
                                Text("Restaurants")
                                Image(systemName: "fork.knife")
                            }
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.colorDark)
                            .cornerRadius(15)
                        }
                    }
                }
            }.foregroundColor(Color.white)
        }
    }
