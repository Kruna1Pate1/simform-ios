//
//  FirstCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class FirstCoordinator: NCoordinator {
    
    var childCoordinators: [NCoordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let firstVC = UIStoryboard(name: "CoordinatorPattern", bundle: nil).instantiateViewController(withIdentifier: "FirstCVC") as? FirstCoordinatorViewController else { return }
        firstVC.coordinator = self
        firstVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(firstVC, animated: true)
    }
    
    func goToSecondVC() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        secondCoordinator.start()
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
    
    func finishToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
