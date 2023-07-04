//
//  APIManager+EndPointType.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Alamofire

protocol SpotifyEndPointType {
    
    // MARK: Variables
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    
}
