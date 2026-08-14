//
//  RestaurantDetailView.swift
//  FoodPin
//
//  Created by Simon Ng on 30/10/2025.
//

import SwiftUI

struct RestaurantDetailView: View {

    @Binding var restaurant: Restaurant

    var body: some View {
        ScrollView {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 445)
                .overlay {
                    VStack {
                        Button {
                            restaurant.isFavorite.toggle()
                        } label: {
                            Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 30))
                                .foregroundStyle(restaurant.isFavorite ? .yellow : .white)
                        }
                            .frame(
                                minWidth: 0, maxWidth: .infinity, minHeight: 0,
                                maxHeight: .infinity, alignment: .topTrailing
                            )
                            .padding()
                            .padding(.top, 40)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(restaurant.name)
                                .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                                .bold()

                            Text(restaurant.type)
                                .font(.system(.headline, design: .rounded))
                                .padding(.all, 5)
                                .background(Color.black)
                        }
                        .frame(
                            minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,
                            alignment: .bottomLeading
                        )
                        .foregroundStyle(.white)
                        .padding()
                    }

                }
            Text(restaurant.description)
                .padding()

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("ADDRESS")
                        .font(.system(.headline, design: .rounded))

                    Text(restaurant.location)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("PHONE")
                        .font(.system(.headline, design: .rounded))

                    Text(restaurant.phone)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RestaurantDetailView(
        restaurant: .constant(Restaurant(
            name: "Cafe Deadend", type: "Coffee & Tea Shop",
            location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423",
            description:
                "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.",
            image: "cafedeadend", isFavorite: true)))
}
