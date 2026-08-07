//
//  RestaurantListView.swift
//  FoodPinExercise
//
//  Created by donghs on 8/7/26.
//

import SwiftUI

struct RestaurantListView: View {
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant",
        "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate",
        "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional",
        "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen",
    ]

    var restaurantImages = [
        "cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier",
        "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf",
        "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask",
    ]

    var restaurantLocations = [
        "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
        "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York",
        "New York", "New York", "London", "London", "London", "London",
    ]

    var restaurantTypes = [
        "Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery",
        "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American",
        "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish",
        "Spanish", "Spanish", "British", "Thai",
    ]

    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                // FullImageRow(
                //     name: restaurantNames[index],
                //     type: restaurantTypes[index],
                //     location: restaurantLocations[index],
                //     imageName: restaurantImages[index]
                // )
                BasicTextImageRow(
                    name: restaurantNames[index],
                    imageName: restaurantImages[index],
                    type: restaurantTypes[index],
                    location: restaurantLocations[index]
                )
                .listRowSeparator(.hidden)
                // .alignmentGuide(.listRowSeparatorLeading) { dimensions in
                //     dimensions[.leading]
                // }
            }
        }
        .listStyle(.plain)
    }
}

struct BasicTextImageRow: View {
    let name: String
    let imageName: String
    let type: String
    let location: String

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))

                Text(type)
                    .font(.system(.body, design: .rounded))

                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct FullImageRow: View {
    var name: String
    var type: String
    var location: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))

                Text(type)
                    .font(.system(.body, design: .rounded))

                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }

}

#Preview {
    RestaurantListView()
}

#Preview("Dark mode") {
    RestaurantListView()
        .preferredColorScheme(.dark)
}
