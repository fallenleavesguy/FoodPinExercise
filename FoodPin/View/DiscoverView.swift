//
//  DiscoverView.swift
//  FoodPin
//
//  Created by donghs on 8/21/26.
//

import SwiftUI
import CloudKit

struct DiscoverView: View {
    @State private var showLoadingIndicator = false
    @State private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()

    private func getImageURL(restaurant: CKRecord) -> URL? {
        guard let image = restaurant.object(forKey: "image"),
            let imageAsset = image as? CKAsset
        else {
            return nil
        }

        return imageAsset.fileURL
    }

    var body: some View {
        NavigationStack {
            ZStack {
                List(cloudStore.restaurants, id: \.recordID) { restaurant in
                    HStack {
                        AsyncImage(url: getImageURL(restaurant: restaurant)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        Text(restaurant.object(forKey: "name") as! String)
                    }
                }
                .listStyle(PlainListStyle())
                .task {
                    cloudStore.fetchRestaurantsWithOperational {
                        showLoadingIndicator = false
                    }
                    // do {
                    //     try await cloudStore.fetchRestaurants()

                    // } catch {
                    //     print(error)
                    // }
                }
                .navigationTitle("Discover")
                .navigationBarTitleDisplayMode(.automatic)
                .onAppear {
                    showLoadingIndicator = true
                }
                .refreshable {
                    cloudStore.fetchRestaurantsWithOperational() {
                        showLoadingIndicator = false
                    }
                }

                if showLoadingIndicator {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    DiscoverView()
}
