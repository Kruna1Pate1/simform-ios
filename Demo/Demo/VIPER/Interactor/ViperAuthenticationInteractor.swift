//
//  ViperAuthenticationService.swift
//  Demo
//
//  Created by Krunal Patel on 21/06/23.
//

import Foundation


class ViperAuthenticationInteractor {
        
    private let credential = Credential(email: "krunal.patel@simformsolutions.com", password: "Krunal@123")
    
    func performLogin(credential: Credential, compeletion: @escaping (Result<ViperLoginResponse, CustomError>) -> Void) {
        if self.credential == credential {
            compeletion(.success(ViperLoginResponse(email: credential.email, token: UUID().uuidString)))
        } else {
            compeletion(.failure(CustomError(title: APIError.errorAlertTitle, body: "Invalid credentials")))
        }
    }
}
