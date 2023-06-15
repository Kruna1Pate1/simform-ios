//
//  AFApiManager.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import Foundation
import Alamofire

class AFApiManager {
    
    private init() { }
    
    static let shared: AFApiManager = AFApiManager()
    
    func call<Response>(url: String, params: Parameters? = nil, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, completion: @escaping (Result<Response, ApiError>) -> ()) where Response: Codable {
        
        AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self) { response in
            
            guard let urlResponse = response.response, response.error == nil else {
                completion(.failure(.unknownError(response.error?.localizedDescription ?? "Unknown error")))
                return
            }
            
            guard 200...299 ~= urlResponse.statusCode else {
                completion(.failure(.unsuccessful(code: urlResponse.statusCode)))
                return
            }
            
            guard 204 != urlResponse.statusCode else {
                completion(.success(BaseResponse<DefaultCodable>(responseCode: 204, isSuccess: true) as! Response))
                return
            }
            
            guard let data = response.value else {
                completion(.failure(.unknownError("Empty body")))
                return
            }
            
            completion(.success(data))
        }
        
    }
}
