//
//  ScrollViewController.swift
//  Demo
//
//  Created by Krunal Patel on 20/04/23.
//

import UIKit

class ScrollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
