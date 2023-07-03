//
//  CustomSegmentedControl.swift
//  Demo
//
//  Created by Krunal Patel on 30/06/23.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    
    private let selectedImage = UIImage(named: "radio_selected")?.resizedImage(to: CGSize(width: 18, height: 18))
    private let deselectedImage = UIImage(named: "radio_deselected")?.resizedImage(to: CGSize(width: 18, height: 18))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    // MARK: - Methods
    private func updateView() {
        addTarget(self, action: #selector(updateValue), for: .valueChanged)
        updateValue()
    }
    
    @objc
    private func updateValue() {
        for i in 0..<numberOfSegments {
            if (i != selectedSegmentIndex) {
                self.setImage(deselectedImage, forSegmentAt: i)
            }
        }
        setImage(selectedImage, forSegmentAt: self.selectedSegmentIndex)
    }
}
