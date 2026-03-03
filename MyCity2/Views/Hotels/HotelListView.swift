import SwiftUI

struct HotelListView: View {
    @State private var viewModel = HotelsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !viewModel.hotels.isEmpty {
                    LazyVGrid(columns: [GridItem()]) {
                        ForEach(viewModel.hotels) { hotel in
                            NavigationLink(destination: HotelView(hotel: hotel)) {
                                HotelCardView(hotel: hotel)
                                    .background(Color.colorLight.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding(5)
                            }
                        }
                    }
                    .padding()
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    Text("No Hotels Available")
                        .foregroundColor(.white)
                }
            }
            .background(Color.colorLight)
            .navigationTitle("Hotels")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await viewModel.loadHotels()
            }
        }
    }
}

struct HotelCardView: View {
    var hotel: HotelData
    
    var body: some View {
        VStack {
            Text(hotel.name)
                .fontWeight(.bold)
                .foregroundColor(.accentGold)

            Text(hotel.location)
                .font(.subheadline)
                .foregroundColor(.white)
            Text(hotel.price)
                .font(.subheadline)
                .foregroundColor(.white)
            Text(hotel.isAvailable.map { $0 ? "Available" : "Limited" } ?? "Unknown")

            HStack(spacing:1) {
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
            }
            .foregroundColor(.accentGold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorDark)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct HotelView: View {
    @State private var viewModel = HotelsViewModel()
    var hotel: HotelData

    var body: some View {
        ZStack {
            Color.colorLight
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing:20) {
                    Text("Hotel Details for \(hotel.name)")
                        .font(.title2)
                        .foregroundColor(.accentGold)
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Järnvägsgatan 31, 553 15 Jönköping, Sweden")
                    }
                    
                    Image("jonkoping")
                        .resizable()
                        .scaledToFit()
                    
                    Button(action: {}) {
                        Link("Book Now", destination: viewModel.bookingURL)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.colorLight)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(maxWidth: 400)
                .background(Color.colorDark)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .padding()
        }
        .navigationTitle("Hotel Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HotelListView()
}
