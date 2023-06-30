//
//  CheckBox.swift
//  Demo
//
//  Created by Krunal Patel on 30/06/23.
//

import UIKit

@IBDesignable
class CheckBox: UIControl {
    
    private let checkImage = UIImage(systemName: "checkmark")?.resizedImage(to: 12)

    private var isChecked: Bool = false {
        didSet {
            updateCheck()
        }
    }
    
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
        layer.borderWidth = 1
        layer.borderColor = tintColor.cgColor
        addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        let imageView = UIImageView(image: checkImage)
        imageView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        addSubview(imageView)
    }
    
    private func updateCheck() {
        subviews.first?.isHidden = isChecked
    }
    
    @objc
    private func toggleCheck() {
        isChecked.toggle()
    }
}
