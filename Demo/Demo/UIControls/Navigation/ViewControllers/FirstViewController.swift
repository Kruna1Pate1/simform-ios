//
//  FirstViewController.swift
//  Demo
//
//  Created by Krunal Patel on 24/04/23.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.hidesBottomBarWhenPushed = true
    }
    
    @IBAction func presentWithSeprateNavigation(sender: UIButton) {
        if let firstPVC = storyboard?.instantiateViewController(withIdentifier: "FirstPVC") {
            let navigationController = UINavigationController(rootViewController: firstPVC)
            navigationController.title = "Sub Navigation Controller"
            present(navigationController, animated: true)
        }
    }
    
    @IBAction func goToCoordinatorPattern(sender: UIButton) {
        let firstCoordinator = FirstCoordinator(navigationController: navigationController!)
        let b = UIButton()
        firstCoordinator.start()
    }
}
