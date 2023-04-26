//
//  MySegmentedControl.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

@IBDesignable
class MySegmentedControl: UISegmentedControl {

    private lazy var radius: CGFloat = 0
    
    @IBInspectable
    private var rounded: Bool = false {
        didSet {
            radius = rounded ? bounds.height / 2 : 0
        }
    }
    
    /// Configure selected segment inset, can't be zero or size will error when click segment
    private var segmentInset: CGFloat = 0.1 {
        didSet{
            if segmentInset == 0 {
                segmentInset = 0.1
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
        
        // Find selectedImageView
        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            // Configure selectedImageView Color
            selectedImageView.backgroundColor = selectedSegmentTintColor
            selectedImageView.image = nil
            
            // Configure selectedImageView Inset with SegmentControl
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            // Configure selectedImageView cornerRadius
            selectedImageView.layer.cornerRadius = radius
            selectedImageView.layer.masksToBounds = true
            
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
}
