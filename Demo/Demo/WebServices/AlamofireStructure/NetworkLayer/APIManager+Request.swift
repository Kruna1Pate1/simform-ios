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
    case uploadImage
    case loadImage(url: String)
    case downloadFile(url: String)
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
        case .uploadImage:
            return "https://api.imgbb.com/"
        case .loadImage(let url), .downloadFile(let url):
            return url
        }
    }
    
    var api: String {
        switch self {
        case .uploadImage, .loadImage, .downloadFile:
            return ""
        default:
            return "api/"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "users"
        case .update(let userId), .getUser(let userId):
            return "users/" + userId
        case .uploadImage:
            return "1/upload?key=c7ff9cb8aa396cf2bd53bb631e48db32"
        case .loadImage, .downloadFile:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .register, .uploadImage:
            return .post
        case .update:
            return .put
        case .getUser, .loadImage, .downloadFile:
            return .get
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.api + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
