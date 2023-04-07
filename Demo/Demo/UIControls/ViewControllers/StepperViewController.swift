   //
//  StepperViewController.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class StepperViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var fontSizeStepper: UIStepper!
    @IBOutlet weak var rotationStepper: UIStepper!
    @IBOutlet var colorSteppers: [UIStepper]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fontSizeStepper.value = welcomeLabel.font.pointSize

        if let rgbColors = welcomeLabel.textColor.cgColor.components {
            for (index, stepper) in colorSteppers.enumerated() {
                stepper.value = rgbColors[index]
            }
        }
        
        rotationStepper.tintColor = .black
        rotationStepper.setDecrementImage(UIImage(named: "rotate_left")?.resizedImage(to: 20), for: .normal)
        rotationStepper.setIncrementImage(UIImage(named: "rotate_right")?.resizedImage(to: 20), for: .normal)
    }
    
    @IBAction func changeFont(_ sender: UIStepper) {
        print(sender.value)
        welcomeLabel.font = welcomeLabel.font.withSize(sender.value)
    }
    
    @IBAction func changeColor(_ sender: UIStepper) {
        print(sender.value)
        guard let rgbColors = welcomeLabel.textColor.cgColor.components else {
            return
        }
        
        switch(sender) {
        case colorSteppers[0]:
            welcomeLabel.textColor = UIColor(red: sender.value, green: rgbColors[1], blue: rgbColors[2], alpha: 1)
        case colorSteppers[1]:
            welcomeLabel.textColor = UIColor(red: rgbColors[0], green: sender.value, blue: rgbColors[2], alpha: 1)
        case colorSteppers[2]:
            welcomeLabel.textColor = UIColor(red: rgbColors[0], green: rgbColors[1], blue: sender.value, alpha: 1)
        default:
            break
        }
    }
    
    @IBAction func rotate(_ sender: UIStepper) {
        print(sender.value * 90)
        welcomeLabel.rotate(degrees: sender.value * 90)
    }
}
        
extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
