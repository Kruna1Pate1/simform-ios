//
//  MultipartFormData.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import Foundation

struct MultiPartFormData {
    
    private init() { }
    
    static let boundary = UUID().uuidString
    
    static func getStringFormData(params: [String: (String, filename: String?)]) -> Data {
        var body = Data()
        
        for (key, (data, filename)) in params {
            body.append("--\(boundary)\r\n")
            
            if let filename = filename {
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
            } else {
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n")
            }
            
            body.append("\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--")
        return body
    }
    
    static func getBindaryFormData(params: [String: (Data, filename: String)]) -> Data {
        var body = Data()
        
        for (key, (data, filename)) in params {
            body.append("--\(boundary)\r\n")
            
            body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: image/jpeg\r\n")
            body.append("\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--")
        return body
    }
}
