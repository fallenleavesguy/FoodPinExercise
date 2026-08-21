//
//  MainView.swift
//  FoodPin
//
//  Created by donghs on 8/21/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTabIndex = 0

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            Tab(value: 0) {
                RestaurantListView()
            } label: {
                Label("Favorites", systemImage: "tag.fill")
            }

            Tab(value: 1) {
                Text("Discover")
            } label: {
                Label("Discover", systemImage: "wand.and.rays")
            }

            Tab(value: 2) {
                Text("About")
            } label: {
                Label("About", systemImage: "square.stack")
            }
        }
        .tint(Color("NavigationBarTitle"))

    }
}

#Preview {
    MainView()
}
