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
    
    var expand: ((_ expanded: Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func changeExpantion(_ sender: UIButton) {
        lblDescription.numberOfLines = sender.isSelected ? 0 : 2
        print(lblDescription.numberOfLines)
        expand?(sender.isSelected)
    }
}
