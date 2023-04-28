//
//  SecondPresentViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/04/23.
//

import UIKit

class SecondPresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentThirdPVC(_ sender: UIButton) {
        if let thirdPVC = storyboard?.instantiateViewController(withIdentifier: "ThirdPVC") {
            navigationController?.show(thirdPVC, sender: nil)
        }
    }
}
