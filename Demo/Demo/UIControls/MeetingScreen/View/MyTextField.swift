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
            rightViewMode = .always
            let imageView = UIImageView(image: rightImage?.resizedImage(to: CGSizeMake(22, 22)))
            imageView.tintColor = .lightGray
            imageView.contentMode = .right
            rightView = imageView
            rightView?.tintColor = .lightGray
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            leftViewMode = .always
            let imageView = UIImageView(image: leftImage?.resizedImage(to: CGSizeMake(22, 22)))
            imageView.tintColor = .lightGray
            imageView.contentMode = .left
            leftView = imageView
            leftView?.tintColor = .lightGray
        }
    }
    
    let textPadding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 40)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: 0, bottom: 0, right: 15))
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
    
    private func updateView() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        returnKeyType = .done
    }
}
