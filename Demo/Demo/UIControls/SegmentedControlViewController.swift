//
//  SegmentedControlViewController.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class SegmentedControlViewController: UIViewController {
    
    @IBOutlet weak var oddEvenSegment: UISegmentedControl!
    @IBOutlet weak var numbersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oddEvenSegment.setEnabled(true, forSegmentAt: 0)
        oddEvenSegment.setAction(UIAction {_ in
            print("Showing all numbers")
        }, forSegmentAt: 0)
        oddEvenSegment.setTitle("All", forSegmentAt: 0)
        changeNumber(oddEvenSegment)
    }
    
    @IBAction func changeNumber(_ sender: UISegmentedControl) {
        var data: String = ""
        switch sender.selectedSegmentIndex {
        case 0:
            for i in 1...10 {
                data.append("*\(i)\n")
                //                data += "\u{2022} \(i)\n"
            }
        case 1:
            for i in stride(from: 1, through: 20, by: 2) {
                //                data.append("- \(i)\n")
                data += "\u{2022} \(i)\n"
            }
        case 2:
            for i in stride(from: 2, through: 20, by: 2) {
                //                data.append("- \(i)\n")
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
        } else {
            self.view.backgroundColor = UIColor.darkGray
            numbersLabel.textColor = UIColor.white
        }
    }
}
