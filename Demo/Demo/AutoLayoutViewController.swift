//
//  AutoLayoutViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/03/23.
//

import UIKit

class AutoLayoutViewController: UIViewController {

    @IBOutlet weak var agreementLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
}
