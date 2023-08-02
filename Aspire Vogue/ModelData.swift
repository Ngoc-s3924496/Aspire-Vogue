//
//  ModelData.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 31/07/2023.
//

import Foundation

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
