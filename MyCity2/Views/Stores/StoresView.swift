//
//  StoresView.swift
//  MyCity2
//
//  Created by ahmed elhasan on 2026-02-23.
//

import SwiftUI

struct StoresView: View {
    @Environment(\.openURL) var openURL
    @State private var viewModel = StoresViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorLight
                    .ignoresSafeArea()
                ScrollView {
                    ForEach(viewModel.filteredStores) { store in
                        VStack {
                            Text(store.name)
                                .foregroundColor(.accentGold)
                            Button(action: {
                                if let url = viewModel.getValidURL(from: store.url) {
                                    openURL(url)
                                }
                            }) {
                                Text("Open Store Homepage")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.colorLight)
                                    .cornerRadius(10)

                            }
                        }.padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.colorDark)
                        .cornerRadius(10)
                        .padding(.bottom, 6)
                    }
                }.padding()
            }.navigationTitle("Stores")
                .searchable(text: $viewModel.searchText)
            .onAppear {
                Task {
                    await viewModel.loadStores()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        StoresView()
    }
}
