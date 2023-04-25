//
//  ContentCell.swift
//  Demo
//
//  Created by Krunal Patel on 19/04/23.
//

import UIKit

class ComponentCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        lblTitle.layer.cornerRadius = 20
        lblTitle.clipsToBounds = true
        lblTitle.textAlignment = .center
    }
}
