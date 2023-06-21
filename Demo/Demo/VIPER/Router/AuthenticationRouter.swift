//
//  AuthenticationRouter.swift
//  Demo
//
//  Created by Krunal Patel on 21/06/23.
//

import UIKit

class AuthenticationRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToHome(email: String) {
        let vc = ViperHomeVC.instantiate(from: .viper)
        vc.email = email
        navigationController.viewControllers[1...] = [vc]
    }
}
