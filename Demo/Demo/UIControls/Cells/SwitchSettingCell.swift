//
//  SwitchSettingCell.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

class SwitchSettingCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchEnable: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
