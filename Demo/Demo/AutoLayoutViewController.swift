//
//  AutoLayoutViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/03/23.
//

import UIKit
import NotificationCenter

class AutoLayoutViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, BackgroundColorDelegate {
    
    @IBOutlet var containerView: ContainerView!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnClickMe: MyButton!
    @IBOutlet weak var tfBackground: UITextField!
    @IBOutlet weak var taHistory: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var historySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
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
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style:   UIBarButtonItem.Style.done, target: self, action: #selector(self.doneclick))
        toolbar.setItems([.flexibleSpace(), donebutton], animated: false)
        tfBackground.inputAccessoryView = toolbar
        taHistory.inputAccessoryView = toolbar
    }
    
    
    @IBAction func touchUp(_ sender: MyButton, forEvent event: UIEvent) {
        print(event.description)
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
        print(sender.outlined)
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
    
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        
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
    
    @objc func doneclick() {
        //this line will dismiss the Keyboard
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        //with line below ,we can get the keyboard size.
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    @objc func keyboardWillHide(notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
    }
    
    static func fromName(_ name: String?) -> UIColor? {
        switch name {
        case "red":
            return UIColor.red
        case "blue":
            return UIColor.blue
        case "brown":
            return UIColor.brown
        case "green":
            return UIColor.green
        case "yellow":
            return UIColor.yellow
        case "black":
            return UIColor.black
        case "white":
            return UIColor.white
        default :
            return nil
        }
    }
}
