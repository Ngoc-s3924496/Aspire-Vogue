import SwiftUI
import Combine

class ShopDataStore: ObservableObject {
    @Published var shops: [Shop]
    @Published var lovedFilter: Bool
    @Published var searchShow: Bool
    
    init() {
        shops = decodeJsonFromJsonFile(jsonFile: "Data.json")
        lovedFilter = false
        searchShow = false
    }
    
    // Method to toggle the loved state of a shop
    func toggleLoved(for shop: Shop) {
        if let index = shops.firstIndex(where: { $0.id == shop.id }) {
            shops[index].loved.toggle()
        }
    }
    
    // Method to write shop data to Data.json
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

// Method to read from Data.json
func decodeJsonFromJsonFile(jsonFile: String) -> [Shop] {
    if let file = Bundle.main.url(forResource: jsonFile, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Shop].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFile) file")
    }
    return [ ] as [Shop]
}
