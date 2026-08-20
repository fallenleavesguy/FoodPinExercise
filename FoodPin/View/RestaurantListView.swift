import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var showNewRestaurant = false
    @State private var searchText = ""
    @State private var searchResult: [Restaurant] = []
    @State private var isSearchActive = false
    
    @Query var restaurants: [Restaurant] 

    private func deleteRecord(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = restaurants[index]
            modelContext.delete(itemToDelete)
        }
        // let itemsToDelete = indexSet.map { restaurants[$0] }

        // for itemToDelete in itemsToDelete {
        //     modelContext.delete(itemToDelete)
        // }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if restaurants.count == 0 {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    let listItems = isSearchActive ? searchResult : restaurants

                    ForEach(listItems) { restaurant in
                        ZStack(alignment: .leading) {
                            NavigationLink(
                                destination: RestaurantDetailView(restaurant: restaurant)
                            ) {
                                EmptyView()
                            }
                            .opacity(0)

                            BasicTextImageRow(restaurant: restaurant)
                        }
                        // .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        //     Button {

                        //     } label: {
                        //         Image(systemName: "heart")
                        //     }
                        //     .tint(.green)

                        //     Button {

                        //     } label: {
                        //         Image(systemName: "square.and.arrow.up")
                        //     }
                        //     .tint(.orange)
                        // }
                    }
                    .onDelete(perform: deleteRecord(indexSet:))
                    .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button(action: {
                    self.showNewRestaurant = true
                }) {
                    Image(systemName: "plus")
                } 
            }
        }
        .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search restaurants...")
        .searchSuggestions {
            if searchText.isEmpty {
                Text("Cafe").searchCompletion("Cafe")
                Text("Thai").searchCompletion("Thai")
            }
        }
        .onChange(of: searchText) { oldValue, newValue in
            let predicate = #Predicate<Restaurant> {
                $0.name.localizedStandardContains(newValue)
            }
            let descriptor = FetchDescriptor<Restaurant>(predicate: predicate)

            if let result = try? modelContext.fetch(descriptor) {
                searchResult = result
            }
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
    }
}

struct BasicTextImageRow: View {
    
    // MARK: - Binding
    
    @Bindable var restaurant: Restaurant
    
    // MARK: - State variables
    
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(uiImage: restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                    
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.gray)
            }
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .contextMenu {
            
            Button(action: {
                self.showError.toggle()
            }) {
                HStack {
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }) {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button(action: {
                self.showOptions.toggle()
            }) {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
        .sheet(isPresented: $showOptions) {
            
            let defaultText = "Just checking in at \(restaurant.name)"
            
            ActivityView(activityItems: [defaultText, restaurant.image])
        }
        
    }
}

struct FullImageRow: View {
    
    var name: String
    var type: String
    var location: String
    var imageName: String
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                        
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.gray)
                }
                
                if isFavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.yellow)
                }

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

#Preview("BasicTextImageRow", traits: .sizeThatFitsLayout) {
    BasicTextImageRow(
        restaurant: Restaurant(
            name: "Cafe Deadend", type: "Coffee & Tea Shop",
            location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423",
            description:
                "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.",
            image: UIImage(named: "cafedeadend")!, isFavorite: true))
}

#Preview("FullImageRow", traits: .sizeThatFitsLayout) {
    FullImageRow(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", imageName: "cafedeadend", isFavorite: .constant(true))
}
