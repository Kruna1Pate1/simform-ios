//
//  SizeCell.swift
//  Demo
//
//  Created by Krunal Patel on 17/04/23.
//

import UIKit

class SizeCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeButton: UIButton!
    var selection: Bool {
        get {
            sizeButton.isSelected
        }
        set {
            sizeButton.isSelected = newValue
            if newValue {
                sizeButton.tintColor = .blue
                sizeButton.layer.borderColor = UIColor.blue.cgColor
            } else {
                sizeButton.tintColor = .gray
                sizeButton.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sizeButton.clipsToBounds = true
        sizeButton.layer.borderColor = UIColor.darkGray.cgColor
        sizeButton.layer.borderWidth = 0.4
        sizeButton.layer.cornerRadius = sizeButton.bounds.height / 2
        sizeButton.layer.shadowColor = UIColor.darkGray.cgColor
        sizeButton.setTitleColor(.gray, for: .normal)
        sizeButton.setTitleColor(.blue, for: .selected)
    }

    @IBAction func onSelect(_ sender: UIButton) {
        selection = sender.isSelected
    }
}
