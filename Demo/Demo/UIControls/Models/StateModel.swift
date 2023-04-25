//
//  StateModel.swift
//  Demo
//
//  Created by Krunal Patel on 13/04/23.
//

import Foundation

struct StateModel: Decodable {
    let state: String
    let cities: [String]
    
    static func loadData(fromFile fileName: String) -> [StateModel] {
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: url)
                let state = try JSONDecoder().decode([StateModel].self, from: data)
                return state
            }
        } catch {
            print("Loading failed")
        }
        return []
    }
}
