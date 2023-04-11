//
//  ActivityIndicatorViewController.swift
//  Demo
//
//  Created by Krunal Patel on 11/04/23.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnIndicatorControl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnIndicatorControl.isSelected = true
    }
    
    @IBAction func changeIndicator(_ sender: UIButton) {
        sender.isSelected ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
