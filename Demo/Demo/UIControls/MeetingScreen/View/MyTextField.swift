//
//  MyTextField.swift
//  Demo
//
//  Created by Krunal Patel on 18/04/23.
//

import UIKit

@IBDesignable
class MyTextField: UITextField {
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            self.rightViewMode = .always
            var imageView = UIImageView(image: rightImage?.resizedImage(to: CGSizeMake(22, 22)))
            imageView.tintColor = .lightGray
            imageView.contentMode = .right
            self.rightView = imageView
            self.rightView?.tintColor = .lightGray
        }
    }
    
    let textPadding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 40)
    let rightIconPadding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: rightIconPadding)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    private func updateView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.returnKeyType = .done
    }
}
