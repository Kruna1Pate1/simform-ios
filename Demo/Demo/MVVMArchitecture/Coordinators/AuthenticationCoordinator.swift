//
//  AuthenticationCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginVC.instantiate(from: .authentication)
        vc.authenticationCoordinator = self
        vc.hidesBottomBarWhenPushed = true
        navigationController.viewControllers[1...] = [vc]
    }
    
    func goToSignUp() {
        let vc = SignupVC.instantiate(from: .authentication)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHome(email: String) {
        UserManager.shared.sceneDelegate?.appCoordinator?.goToHome(email: email)
    }
}
