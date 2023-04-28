//
//  TimeZoneCell.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class TimeZoneCell: UITableViewCell {

    // MARK: - Outlet
    
    @IBOutlet private weak var imgContry: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuaration Methods
    
    func configureCell(_ name: String, image: UIImage? = nil) {
        lblName.text = name
        imgContry.image = image
    }
}
