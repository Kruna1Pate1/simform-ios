//
//  SizeCell.swift
//  Demo
//
//  Created by Krunal Patel on 17/04/23.
//

import UIKit

class SizeCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLabel: UILabel!
    var selection: Bool {
        get {
            self.isSelected
        }
        set {
            self.isSelected = newValue
            if newValue {
                sizeLabel.textColor = .systemBlue
                sizeLabel.backgroundColor = .systemBlue.withAlphaComponent(0.1)
            } else {
                sizeLabel.textColor = .black
                sizeLabel.backgroundColor = .clear
            }
        }
    }
    
    var isDisabled: Bool = false {
        didSet {
            if isDisabled {
                
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sizeLabel.clipsToBounds = true
        sizeLabel.layer.borderColor = selection ? UIColor.systemBlue.cgColor : UIColor.lightGray.withAlphaComponent(0.5).cgColor
        sizeLabel.layer.cornerRadius = sizeLabel.bounds.height / 2
        sizeLabel.layer.borderWidth = 1.5
        sizeLabel.layer.shadowColor = UIColor.darkGray.cgColor
    }
}
