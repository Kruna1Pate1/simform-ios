//
//  AutoLayoutViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/03/23.
//

import UIKit

class AutoLayoutViewController: UIViewController, BackgroundColorDelegate {
    
    @IBOutlet var containerView: ContainerView!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnClickMe: MyButton!
    @IBOutlet weak var tfBackground: UITextField!
    @IBOutlet weak var taHistory: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        containerView.delegate = self
        
        lblWelcome.text = "Welcome to the Game!"
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = slider.maximumValue / 2
        
        pageControl.currentPage = 1
        pageControl.numberOfPages = 5
        pageControl.layer.cornerRadius = 4
        
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
        containerView.backgroundColor = UIColor(named: sender.text ?? "white")
    }
    
    
    @IBAction func onSlide(_ sender: UISlider) {
        pageControl.numberOfPages = Int(sender.value) % 10
        progress.tintColor = UIColor.random()
        progress.progress = slider.value / 100
    }
    
    func backgroundColorDidChanged(color: UIColor?) {
        guard let color else {
            return
        }
        taHistory.insertText("\(color.accessibilityName.capitalized)\n")
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
}
