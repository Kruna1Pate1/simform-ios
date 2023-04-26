//
//  SegmentedControlViewController.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class SegmentedControlViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var oddEvenSegment: UISegmentedControl!
    @IBOutlet private weak var themeSegment: UISegmentedControl!
    @IBOutlet private weak var bottomSegment: UISegmentedControl!
    @IBOutlet private weak var numbersLabel: UILabel!
    
    // MARK: - Private Variables
    
    private var bottomNavImages: [(outlined: UIImage?, filled: UIImage?)] = [
        (UIImage(named: "home_outlined"), UIImage(named: "home_filled")),
        (UIImage(named: "location_outlined"), UIImage(named: "location_filled")),
        (UIImage(named: "profile_outlined"), UIImage(named: "profile_filled")),
        (UIImage(named: "settings_outlined"), UIImage(named: "settings_filled"))
    ].map {
        ($0.0?.resizedImage(to: 24), $0.1?.resizedImage(to: 28))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        themeSegment.layer.cornerRadius = themeSegment.bounds.height / 2
        themeSegment.setImage(UIImage(named: "sun")?.resizedImage(to: 20), forSegmentAt: 0)
        themeSegment.setImage(UIImage(named: "moon")?.resizedImage(to: 20), forSegmentAt: 1)
                
        oddEvenSegment.setEnabled(true, forSegmentAt: 0)
        oddEvenSegment.setAction(UIAction {_ in
            print("Showing all numbers")
        }, forSegmentAt: 0)
        oddEvenSegment.setTitle("All", forSegmentAt: 0)
        changeNumber(oddEvenSegment)
        
        bottomSegment.clipsToBounds = true
        bottomSegment.layer.masksToBounds = true
        bottomSegment.layer.cornerRadius = 40
        
        for index in 1...bottomSegment.numberOfSegments - 1 {
            bottomSegment.setImage(bottomNavImages[index].outlined, forSegmentAt: index)
        }
        bottomSegment.setImage(bottomNavImages[0].filled, forSegmentAt: 0)
    }
    
    @IBAction func changeNumber(_ sender: UISegmentedControl) {
        var data: String = ""
        switch sender.selectedSegmentIndex {
        case 0:
            for i in 1...10 {
                data.append("*\(i)\n")
            }
        case 1:
            for i in stride(from: 1, through: 20, by: 2) {
                data += "\u{2022} \(i)\n"
            }
        case 2:
            for i in stride(from: 2, through: 20, by: 2) {
                data += "\u{2022} \(i)\n"
            }
        default:
            break
        }
        numbersLabel.attributedText = try? NSAttributedString(markdown: data)
        print(data)
    }

    @IBAction func changeTheme(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.view.backgroundColor = UIColor.white
            numbersLabel.textColor = UIColor.black
            themeSegment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            oddEvenSegment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            bottomSegment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            themeSegment.layer.borderColor = UIColor.black.cgColor
            oddEvenSegment.selectedSegmentTintColor = UIColor.systemBlue
            themeSegment.selectedSegmentTintColor = UIColor.systemBlue
            bottomSegment.selectedSegmentTintColor = UIColor.green
        } else {
            self.view.backgroundColor = UIColor.darkGray
            numbersLabel.textColor = UIColor.white
            themeSegment.tintColor = UIColor.black
            themeSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            oddEvenSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            bottomSegment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            oddEvenSegment.selectedSegmentTintColor = UIColor.orange
            themeSegment.selectedSegmentTintColor = UIColor.orange
            bottomSegment.selectedSegmentTintColor = UIColor.orange
        }
    }
    
    @IBAction func bottomNavigate(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        for i in 0...sender.numberOfSegments - 1 {
            if i == index {
                sender.setImage(bottomNavImages[i].filled, forSegmentAt: i)
            } else {
                sender.setImage(bottomNavImages[i].outlined, forSegmentAt: i)
            }
        }
    }
}
