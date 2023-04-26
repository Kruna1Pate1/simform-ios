//
//  LanguageModel.swift
//  Demo
//
//  Created by Krunal Patel on 07/04/23.
//

struct LanguageModel {
    let name: String
    var isSelected: Bool
    
    init(_ name: String, isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
    
    static func dummyLanguages() -> [LanguageModel] {
        return [
            LanguageModel("English", isSelected: true),
            LanguageModel("简体中文"),
            LanguageModel("Wikang Filipino"),
            LanguageModel("Français"),
            LanguageModel("ગુજરાતી"),
            LanguageModel("हिन्दी"),
            LanguageModel("मराठी")
        ]
    }
}
