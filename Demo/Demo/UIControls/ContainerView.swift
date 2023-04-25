//
//  ContainerView.swift
//  Demo
//
//  Created by Krunal Patel on 03/04/23.
//

import UIKit

class ContainerView: UIView {
    
    weak var delegate: BackgroundColorDelegate?

    override open var backgroundColor: UIColor? {
        didSet {
            delegate?.backgroundColorDidChanged(color: backgroundColor)
        }
    }
}
