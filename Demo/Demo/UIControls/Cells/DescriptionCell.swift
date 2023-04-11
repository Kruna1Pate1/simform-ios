//
//  DescriptionCell.swift
//  Demo
//
//  Created by Krunal Patel on 11/04/23.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnExpand: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func changeExpantion(_ sender: UIButton) {
        lblDescription.numberOfLines = sender.isSelected ? 2 : 0
    }
}
