//
//  APIManager+Request.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Alamofire

// MARK: Enums

enum SpotifyRequestItemsType: Equatable {
    
    case authCode
    case authToken
}

// MARK: Extensions
// MARK: EndPointType

extension SpotifyRequestItemsType: SpotifyEndPointType {
    
    // MARK: Variables
    
    var baseURL: String {
        switch self {
        case .authCode, .authToken:
            return "https://accounts.spotify.com/"
        }
    }
    
    var api: String {
        switch self {
        case .authCode, .authToken:
            return ""
        case .authToken:
            return "api/"
        default:
            return "api/"
        }
    }
    
    var path: String {
        switch self {
        case .authCode:
            return "authorize"
        case .authToken:
            return "token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .authCode:
            return .get
        case .authToken:
            return .post
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.api + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncodin g.default
    }
}
