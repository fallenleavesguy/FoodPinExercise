import CloudKit
import SwiftUI

@Observable class RestaurantCloudStore {

    var restaurants: [CKRecord] = []

    func fetchRestaurants() async throws {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)

        let results = try await publicDatabase.records(matching: query)

        for record in results.matchResults {
            self.restaurants.append(try record.1.get())
        }
    }
}