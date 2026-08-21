//
//  MainView.swift
//  FoodPin
//
//  Created by Simon Ng on 4/11/2025.
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
                DiscoverView()
            } label: {
                Label("Discover", systemImage: "wand.and.rays")
            }
            
            Tab(value: 2) {
                AboutView()
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
