//
//  ThirdPresentViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/04/23.
//

import UIKit

class ThirdPresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToRootVC(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
