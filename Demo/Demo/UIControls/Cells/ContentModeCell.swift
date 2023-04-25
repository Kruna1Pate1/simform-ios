//
//  ContentModeCell.swift
//  Demo
//
//  Created by Krunal Patel on 10/04/23.
//

import UIKit

class ContentModeCell: UITableViewCell {

    @IBOutlet weak var lblContentMode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
