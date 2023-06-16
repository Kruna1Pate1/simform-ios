//
//  AFSLoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Foundation

class AFSLoginViewModel {
    
    let email = Dynamic<String>("")
    let password = Dynamic<String>("")
    let errorMessage = Dynamic<String>("")
    let loginSuccess = Dynamic<String>("")
    
    func validateData(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            errorMessage.value = "Email or Password can't be empty"
        } else if !isValidEmail(email) {
            errorMessage.value = "Email is invalid"
        } else {
            callSignInApi(email: email, password: password)
        }
    }
    
    func callSignInApi(email: String, password: String) {
        let params = ["email": email, "password": password]
        
        APIManager.shared.call(type: .login, params: params) { (result: Result<LoginResponse, CustomError>) in
            switch result {
            case .success(let response):
                guard let token = response.token else {
                    self.errorMessage.value = APIError.genericErrorMessage
                    return
                }
                self.loginSuccess.value = token
            case .failure(let error):
                self.errorMessage.value = error.body
            }
        }
    }
}
