//
//  BaseResponse.swift
//  Demo
//
//  Created by Krunal Patel on 14/06/23.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var responseCode: Int?
    var message: String?
    var isSuccess: Bool?
    var data: T?
    
    init(responseCode: Int? = nil, message: String? = nil, isSuccess: Bool?, data: T? = nil) {
        self.responseCode = responseCode
        self.message = message
        self.isSuccess = isSuccess
        self.data = data
    }
}

struct DefaultCodable: Codable { }
