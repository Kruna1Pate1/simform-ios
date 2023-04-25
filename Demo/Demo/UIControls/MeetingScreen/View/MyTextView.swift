//
//  MyTextView.swift
//  Demo
//
//  Created by Krunal Patel on 18/04/23.
//

import UIKit

@IBDesignable
class MyTextView: UITextView {
    
    @IBInspectable private var placeholder: String? {
        didSet {
            text = placeholder
            isPlaceholderVisible = true
        }
    }
    
    private weak var superDelegate: UITextViewDelegate?
    
    override var delegate: UITextViewDelegate? {
        get {
            super.delegate
        }
        set {
            superDelegate = newValue
        }
    }
    
    private var isPlaceholderVisible = true {
        didSet {
            isPlaceholderVisible ? showPlaceholder() : hidePlaceholder()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateView()
        super.delegate = self
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        updateView()
        super.delegate = self
    }
    
    private func updateView() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 15)
    }
    
    private func showPlaceholder() {
        textColor = .lightGray
        print(placeholder)
        text = placeholder
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
    }
    
    private func hidePlaceholder() {
        textColor = .black
        text = ""
    }
}

extension MyTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let newRange = Range(range, in: textView.text) else { return false }
        
        let newText = textView.text.replacingCharacters(in: newRange, with: text)
        
        if newText.isEmpty {
            isPlaceholderVisible = true
        } else if !text.isEmpty && isPlaceholderVisible {
            isPlaceholderVisible = false
        }
               
        return superDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if isPlaceholderVisible {
            selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        }
        superDelegate?.textViewDidChangeSelection?(textView)
    }
}
