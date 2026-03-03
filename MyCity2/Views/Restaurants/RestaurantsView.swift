//
//  RestaurantsView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import SwiftUI
import Foundation

struct RestaurantsView: View {
    @State private var viewModel = RestaurantsViewModel()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()]) {
                if !viewModel.restaurants.isEmpty {
                    ForEach(viewModel.restaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            RestaurantCardView(restaurant: restaurant)
                                .background(Color.colorLight.opacity(0.5))
                                .cornerRadius(10)
                                .padding(5)
                        }
                    }
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    Text("No Restaurants Available")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .background(Color.colorLight)
        .navigationTitle("Restaurants")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadRestaurants()
            }
        }
    }
}

struct RestaurantCardView: View {
    var restaurant: RestaurantData
    
    var body: some View {
        VStack {
            Text(restaurant.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.accentGold)
            Text(restaurant.food_category)
                .font(.subheadline)
                .foregroundColor(.white)
            Text(restaurant.place_name)
            .padding(.top, 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorDark)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct RestaurantDetailView: View {
    var restaurant: RestaurantData

    var body: some View {
        ZStack{
            Color.colorLight
                .ignoresSafeArea()
            ScrollView {
                Spacer(minLength: 150)
                VStack(spacing: 20) {
                    Text("Restaurant Details for \(restaurant.name)")
                        .font(.title2)
                        .foregroundColor(.accentGold)
                    
                    Image(systemName: "mappin.and.ellipse")
                    Text("Järnvägsgatan 31, 553 15 Jönköping, Sweden")
                    
                    Button(action: {}) {
                        Link("Show location", destination: URL(string:"https://www.google.com/maps/@57.7765376,14.1524992,13z?entry=ttu")!)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.colorLight)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(maxWidth: 400, maxHeight: 600)
                .background(Color.colorDark)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .padding()
        }
        .navigationTitle("Restaurant Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    RestaurantsView()
}
