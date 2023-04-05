//
//  MyButton.swift
//  Demo
//
//  Created by Krunal Patel on 03/04/23.
//

import UIKit

@IBDesignable
class MyButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable
    public var outlined: Bool = false {
        didSet {
            if outlined {
                layer.cornerRadius = 5
                layer.borderColor = currentTitleColor.cgColor
                layer.borderWidth = 2
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
}
