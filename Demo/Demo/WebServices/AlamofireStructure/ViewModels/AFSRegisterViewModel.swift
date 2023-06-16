//
//  AFSLoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Foundation

class AFSRegisterViewModel {
    
    let errorMessage = Dynamic<String>("")
    let registerSuccess = Dynamic<String>("")
    
    func validateData(name: String, email: String, number: String, country: String) {
        
        guard !name.isEmpty else {
            errorMessage.value = "Name can't be empty"
            return
        }
        
        guard !email.isEmpty else {
            errorMessage.value = "Email can't be empty"
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage.value = "Invalid email"
            return
        }
        
        callRegisterApi(name: name, email: email, number: number, country: country)
    }
    
    func callRegisterApi(name: String, email: String, number: String, country: String) {
        let params = ["name": name,
                      "email": email,
                      "number": number,
                      "country": country]
        APIManager.shared.call(type: .register, params: params) { (result: Result<UserDetailResponse, CustomError>) in
            switch result {
            case .success(let response):
                guard let userId = response.id else {
                    self.errorMessage.value = APIError.genericErrorMessage
                    return
                }
                self.registerSuccess.value = userId
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
}
