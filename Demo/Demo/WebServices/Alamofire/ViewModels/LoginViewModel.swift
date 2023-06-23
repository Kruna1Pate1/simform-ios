//
//  LoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import Foundation

class LoginViewModel {
    
    private let loginUrl = AFDemoConstants.baseUrl + "/auth/login"
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ApiError>) -> ()) {
        let loginDetails = LoginRequest(usernmame: username, password: password)
        let parameters = ["username": username, "password": password]
        AFApiManager.shared.call(url: loginUrl, params: parameters, method: .post, completion: completion)
    }
}
