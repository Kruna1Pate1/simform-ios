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
    
    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
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
