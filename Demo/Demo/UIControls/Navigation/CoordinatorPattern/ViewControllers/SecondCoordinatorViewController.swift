//
//  SecondCoordinatorViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class SecondCoordinatorViewController: UIViewController {
    
    // MARK: - Variables
    weak var coordinator: SecondCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToThirdVC(_ sender: UIButton) {
        coordinator?.goToThirdVC()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        coordinator?.finish()
    }
    
    @IBAction func goToRoot(_ sender: UIButton) {
        coordinator?.finishToRoot()
    }
}
