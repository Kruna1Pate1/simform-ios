//
//  ThirdCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class ThirdCoordinator: NCoordinator {
    
    var childCoordinators: [NCoordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let thirdVC = UIStoryboard(name: "CoordinatorPattern", bundle: nil).instantiateViewController(withIdentifier: "ThirdCVC") as? ThirdCoordinatorViewController else { return }
        thirdVC.coordinator = self
        navigationController.pushViewController(thirdVC, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
    
    func finishToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
