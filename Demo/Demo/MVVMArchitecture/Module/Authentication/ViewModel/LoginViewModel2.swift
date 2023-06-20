//
//  LoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import Foundation

class LoginViewModel2 {
    
    var loginSuccess = Dynamic<(String, String)>(("", ""))
    var errorMessage = Dynamic<String>("")
    private let credential = Credential(email: "krunal.patel@simformsolutions.com", password: "Krunal@123")
    
    func validate(email: String, password: String) {
        if email.isEmpty {
            errorMessage.value = "Username is empty"
            return
        }
        
        if password.isEmpty {
            errorMessage.value = "Passowrd is empty"
            return
        }
        
        if !isValidEmail(email) {
            errorMessage.value = "Invalid email"
        }
        
        performLogin(credential: Credential(email: email, password: password))
    }
    
    private func performLogin(credential: Credential) {
        if self.credential == credential {
            loginSuccess.value = (credential.email ?? "", UUID().uuidString)
        } else {
            errorMessage.value = "Invalid username or password"
        }
    }
}
