//
//  APIManager+EndPointType.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Alamofire

protocol EndPointType {
    
    // MARK: Variables
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
//    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    
}
