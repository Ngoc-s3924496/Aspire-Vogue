import SwiftUI
import Combine

class ShopDataStore: ObservableObject {
    @Published var shops: [Shop]
    @Published var LovedFilter: Bool
    @Published var SearchShow: Bool
    
    init() {
        shops = decodeJsonFromJsonFile(jsonFile: "Data.json")
        LovedFilter = false
        SearchShow = false
    }
    
    // Method to toggle the loved state of a shop
    func toggleLoved(for shop: Shop) {
        if let index = shops.firstIndex(where: { $0.id == shop.id }) {
            shops[index].loved.toggle()
        }
    }
    
    func saveDataToFile() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(shops)
            if let fileURL = Bundle.main.url(forResource: "Data", withExtension: "json") {
                try data.write(to: fileURL)
            }
        } catch {
            print("Error saving data to JSON file: \(error)")
        }
    }
}
