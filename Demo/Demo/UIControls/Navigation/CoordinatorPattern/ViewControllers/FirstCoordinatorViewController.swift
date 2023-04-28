//
//  FirstCoordinatorViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class FirstCoordinatorViewController: UIViewController {
    
    // MARK: - Variables
    weak var coordinator: FirstCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToSecondVC(_ sender: UIButton) {
        coordinator?.goToSecondVC()
    }
}
