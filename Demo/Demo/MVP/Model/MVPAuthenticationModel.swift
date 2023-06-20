//
//  MVPAuthenticationModel.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

struct MVPCredential: Equatable {
    let email: String?
    let password: String?
}

struct MVPLoginResponse {
    let email: String?
    let token: String?
}
