//
//  AuthenticationEntity.swift
//  Demo
//
//  Created by Krunal Patel on 21/06/23.
//

struct ViperCredential: Equatable {
    let email: String?
    let password: String?
}

struct ViperLoginResponse {
    let email: String?
    let token: String?
}
