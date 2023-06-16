//
//  APIManager+Request.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Alamofire

// MARK: Enums

enum RequestItemsType: Equatable {
    
    case login
    case register
    case update(userId: String)
    case getUser(userId: String)
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Variables
    
    var baseURL: String {
        switch self {
        case .login:
            return "https://reqres.in/"
        case .register, .update, .getUser:
            return "https://6482a62bf2e76ae1b95b5f48.mockapi.io/"
        }
    }
    
    var api: String {
        return "api/"
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "users"
        case .update(let userId), .getUser(let userId):
            return "users/" + userId
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .update:
            return .put
        case .getUser:
            return .get
        }
    }
    
    var url: URL {
        switch self {
        case .login, .register, .update, .getUser:
            return URL(string: self.baseURL + self.api + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login, .register, .update, .getUser:
            return JSONEncoding.default
        }
    }
}
