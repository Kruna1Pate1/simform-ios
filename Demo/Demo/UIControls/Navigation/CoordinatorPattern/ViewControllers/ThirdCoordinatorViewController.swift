//
//  ThirdCoordinatorViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class ThirdCoordinatorViewController: UIViewController {
    
    // MARK: - Variables
    weak var coordinator: ThirdCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        coordinator?.finish()
    }
    
    @IBAction func goToRoot(_ sender: UIButton) {
        coordinator?.finishToRoot()
    }
}
