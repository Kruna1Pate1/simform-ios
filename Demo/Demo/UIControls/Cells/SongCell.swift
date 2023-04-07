//
//  CollectionViewCell.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    
    var song: SongModel? {
        didSet {
            guard let song else { return }
            
            thumbnail.image = UIImage(named: song.thumbnailName) ?? UIImage(named: "song_thumbnail")
        }
    }
    
}

