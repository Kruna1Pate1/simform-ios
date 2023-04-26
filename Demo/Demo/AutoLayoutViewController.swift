//
//  AutoLayoutViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/03/23.
//

import UIKit
import NotificationCenter

class AutoLayoutViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, BackgroundColorDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var containerView: ContainerView!
    @IBOutlet private weak var agreementLabel: UILabel!
    @IBOutlet private weak var progress: UIProgressView!
    @IBOutlet private weak var lblWelcome: UILabel!
    @IBOutlet private weak var btnClickMe: MyButton!
    @IBOutlet private weak var tfBackground: UITextField!
    @IBOutlet private weak var taHistory: UITextView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var historySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObservers()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        containerView.delegate = self
        taHistory.delegate = self
        tfBackground.delegate = self
        
        let quote = "Welcome! Check my portfolio?"
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.orange
        shadow.shadowBlurRadius = 5
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .shadow: shadow
        ]
        
        let attributedText = NSMutableAttributedString(string: quote, attributes: attributes)
        attributedText.addAttributes([
            .link: "https://krunalpatel.me",
            .foregroundColor: UIColor.blue
        ], range: NSRange(location: 18, length: 9))
        
        attributedText.removeAttribute(.shadow, range: NSRange(location: 18, length: 9))
        lblWelcome.attributedText = attributedText
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = slider.maximumValue / 2
        slider.minimumValueImage = UIImage(named: "brightness_decrease")
        slider.maximumValueImage = UIImage(named: "brightness_increase")
        
        pageControl.currentPage = 1
        pageControl.numberOfPages = 5
        pageControl.layer.cornerRadius = 4
        
        setupAccessoryViews()
    }
    
    private func setupAccessoryViews() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style:   UIBarButtonItem.Style.done, target: self, action: #selector(self.doneclick))
        toolbar.setItems([.flexibleSpace(), donebutton], animated: false)
        tfBackground.inputAccessoryView = toolbar
        taHistory.inputAccessoryView = toolbar
    }
    
    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func touchUp(_ sender: MyButton, forEvent event: UIEvent) {
    }
    
    override public var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation.isPortrait {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
            }
            return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .compact)])
        }
        return super.traitCollection
    }
    
    
    @IBAction func clickMe(_ sender: MyButton) {
        sender.outlined.toggle()
        sender.isSelected = !sender.isSelected
        if pageControl.currentPage == (pageControl.numberOfPages - 1) {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        
        containerView.backgroundColor = UIColor.random()
        tfBackground.text = containerView.backgroundColor?.accessibilityName
        
        taHistory.scrollRangeToVisible(NSMakeRange(taHistory.text.count, 0))
    }
    
    @IBAction func changeBackground(_ sender: UITextField) {
        containerView.backgroundColor = UIColor.fromName(sender.text) ?? UIColor.orange
    }
    
    @IBAction func onSlide(_ sender: UISlider) {
        pageControl.numberOfPages = Int(sender.value) % 10
        progress.tintColor = UIColor.random()
        progress.progress = slider.value / 100
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !historySwitch.isOn {
            tfBackground.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneclick()
        return true
    }
    
    func backgroundColorDidChanged(color: UIColor?) {
        guard let color else {
            return
        }
        taHistory.insertText("\(color.accessibilityName.capitalized)\n")
    }
    
    @objc private func doneclick() {
        //this line will dismiss the Keyboard
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        //with line below ,we can get the keyboard size.
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    @objc private func keyboardWillHide(notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0
        }
    }
}
