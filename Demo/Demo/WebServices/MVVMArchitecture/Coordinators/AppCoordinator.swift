//
//  AppCoordinator.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if UserManager.shared.isLoggedIn {
            goToHome(email: UserManager.shared.email ?? "")
        } else {
            goToLogin()
        }
    }
    
    func goToLogin() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        authenticationCoordinator.start()
    }
    
    func goToHome(email: String) {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, email: email)
        homeCoordinator.start()
    }
}
