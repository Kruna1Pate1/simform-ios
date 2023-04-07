//
//  SongModel.swift
//  Demo
//
//  Created by Krunal Patel on 07/04/23.
//

import UIKit

struct SongModel {
    let title: String
    var thumbnailName: String = ""
    let genre: SongGenre
    let singers: [String]
    var rating: Int?
    var isLiked: Bool = false
    
    enum SongGenre: String {
        case pop, hiphop, romantic, rock, folk
    }
    
    static func dummySongs() -> [SongModel] {
        return [
            SongModel(title: "Tum se hi", thumbnailName: "tum_se_hi", genre: .romantic, singers: ["Mohit Chauhan"], isLiked: true),
            SongModel(title: "Afreen afreen", thumbnailName: "afreen_afreen", genre: .folk, singers: ["Momina Mustehsan", "Rahat Fateh Ali Khan"], isLiked: true),
            SongModel(title: "Ranjha", thumbnailName: "ranjha", genre: .romantic, singers: ["B Praak"]),
            SongModel(title: "Radha kaise na jale", thumbnailName: "radha_kaise_na_jale", genre: .folk, singers: ["A. R. Rahman", "Asha Bhosle", "Udit Narayan"], isLiked: true),
        ]
    }
}

