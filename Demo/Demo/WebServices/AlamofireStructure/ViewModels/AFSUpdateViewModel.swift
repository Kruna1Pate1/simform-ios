//
//  AFSLoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Foundation

class AFSUpdateViewModel {
    
    let errorMessage = Dynamic<String>("")
    let registerSuccess = Dynamic<String>("")
    let userDetails = Dynamic<UserDetailResponse?>(nil)
    
    func validateData(userId: String, name: String, email: String, number: String, country: String) {
        
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
        
        callUpdateApi(userId: userId, name: name, email: email, number: number, country: country)
    }
    
    func getUser(userId: String) {
        APIManager.shared.call(type: .getUser(userId: userId)) { (result: Result<UserDetailResponse, CustomError>) in
            switch result {
            case .success(let response):
                self.userDetails.value = response
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func callUpdateApi(userId: String, name: String, email: String, number: String, country: String) {
        let params = ["name": name,
                      "email": email,
                      "number": number,
                      "country": country]
        APIManager.shared.call(type: .update(userId: userId), params: params) { (result: Result<UserDetailResponse, CustomError>) in
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
