//
//  AuthenticationCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var email: String
    
    init(navigationController: UINavigationController, email: String) {
        self.navigationController = navigationController
        self.email = email
    }
    
    func start() {
        let vc = HomeVC.instantiate(from: .home)
        vc.homeCoordinator = self
        vc.hidesBottomBarWhenPushed = true
        navigationController.viewControllers[1...] = [vc]
    }
    
    func goToLogin() {
        UserManager.shared.sceneDelegate?.appCoordinator?.goToLogin()
    }
}
