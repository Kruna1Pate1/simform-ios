//
//  SecondCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class SecondCoordinator: NCoordinator {
    
    var childCoordinators: [NCoordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let secondVC = UIStoryboard(name: "CoordinatorPattern", bundle: nil).instantiateViewController(withIdentifier: "SecondCVC") as? SecondCoordinatorViewController else { return }
        secondVC.coordinator = self
        navigationController.pushViewController(secondVC, animated: true)
    }
    
    func goToThirdVC() {
        let thirdCoordinator = ThirdCoordinator(navigationController: navigationController)
        thirdCoordinator.start()
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
    
    func finishToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
