//
//  MyTextView.swift
//  Demo
//
//  Created by Krunal Patel on 18/04/23.
//

import UIKit

class MyTextView: UITextView {
    
    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    private func updateView() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textContainerInset = padding
    }
}
