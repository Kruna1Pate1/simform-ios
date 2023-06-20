//
//  MVPLoginPresenter.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

protocol LoginDelegate: AnyObject {
    
    func login(didSuccessWith response: MVPLoginResponse)
    func login(didFailedWith error: String)
}

class MVPLoginPresenter {
    
    weak var delegate: LoginDelegate?
    
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
        AuthenticationService.shared.performLogin(credential: credential) { (result: Result<MVPLoginResponse, CustomError>) in
            switch result {
            case .success(let response):
                self.delegate?.login(didSuccessWith: response)
            case .failure(let error):
                self.delegate?.login(didFailedWith: error.body)
            }
        }
    }
}
