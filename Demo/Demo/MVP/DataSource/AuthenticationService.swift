//
//  AuthenticationService.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import Foundation

class AuthenticationService {
    
    private init() { }
    
    static let shared: AuthenticationService = AuthenticationService()
    
    private let credential = Credential(email: "krunal.patel@simformsolutions.com", password: "Krunal@123")
    
    func performLogin(credential: Credential, compeletion: @escaping (Result<MVPLoginResponse, CustomError>) -> Void) {
        if self.credential == credential {
            compeletion(.success(MVPLoginResponse(email: credential.email, token: UUID().uuidString)))
        } else {
            compeletion(.failure(CustomError(title: APIError.errorAlertTitle, body: "Invalid credentials")))
        }
    }
}
