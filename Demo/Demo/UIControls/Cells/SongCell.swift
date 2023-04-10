//
//  CollectionViewCell.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var singers: UILabel!
    
    var song: SongModel? {
        didSet {
            guard let song else { return }
            
            thumbnail.image = UIImage(named: song.thumbnailName) ?? UIImage(named: "song_thumbnail")
            title.text = song.title
            singers.text = song.singers.joined(separator: ",")
            likeButton.isSelected = song.isLiked
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        singers.showsExpansionTextWhenTruncated = true
        
        thumbnail.layer.opacity = 0.4
        thumbnail.backgroundColor = .black
    }
    
    @IBAction func onLike(_ sender: UIButton) {
        song?.isLiked = sender.isSelected
    }
}

