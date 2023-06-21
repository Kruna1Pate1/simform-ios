//
//  ViperLoginPresenter.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

protocol ViperLoginDelegate: AnyObject {
    
    func login(didSuccessWith response: ViperLoginResponse)
    func login(didFailedWith error: String)
}

class ViperLoginPresenter {
    
    weak var delegate: ViperLoginDelegate?
    private let router: AuthenticationRouter
    
    init(navigationController: UINavigationController) {
        self.router = AuthenticationRouter(navigationController: navigationController)
    }
    
    let interactor = ViperAuthenticationInteractor()
    
    func validate(email: String, password: String) {
        if email.isEmpty {
            delegate?.login(didFailedWith: "Username is empty")
            return
        }
        
        if password.isEmpty {
            delegate?.login(didFailedWith: "Password is empty")
            return
        }
        
        if !isValidEmail(email) {
            delegate?.login(didFailedWith: "Invalid email")
            return
        }
        
        performLogin(credential: Credential(email: email, password: password))
    }
    
    func performLogin(credential: Credential) {
        interactor.performLogin(credential: credential) { (result: Result<ViperLoginResponse, CustomError>) in
            switch result {
            case .success(let response):
//                self.delegate?.login(didSuccessWith: response)
                self.router.goToHome(email: response.email ?? "")
            case .failure(let error):
                self.delegate?.login(didFailedWith: error.body)
            }
        }
    }
}
