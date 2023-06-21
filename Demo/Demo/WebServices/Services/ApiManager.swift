//
//  ApiManager.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import Foundation


enum ApiError: Error {
    case invalidUrl
    case timeOut
    case unsuccessful(code: Int)
    case unknownError(_ error: String? = nil)
}

class ApiManager {
    
    private lazy var urlSession: URLSession = {
        let configuaration = URLSessionConfiguration.default
        configuaration.waitsForConnectivity = true
        configuaration.timeoutIntervalForRequest = 30
        configuaration.timeoutIntervalForResource = 60
        configuaration.httpShouldUsePipelining = true
        return URLSession(configuration: configuaration)
    }()
    
    private init() { }
    
    static let shared: ApiManager = ApiManager()
    
    func call<Response>(url: String, method: String = "GET", body: Codable? = nil, completion: @escaping (Result<Response, ApiError>) -> ()) where Response: Codable {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        switch method {
        case "GET":
            break
            
        case "POST", "PUT", "PATCH":
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            if let body = body, let jsonBody = try? encoder.encode(body) {
                request.httpBody = jsonBody
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            }
            
        default:
            break
        }
        
        urlSession.dataTask(with: request) { (data, urlResponse, error) in
            
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(.unknownError("Response is empty")))
                return
            }
            
            guard error == nil else {
                completion(.failure(.unknownError()))
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
            
            do {
                let decoder = JSONDecoder()
                // TODO: - decoder.keyDecodingStrategy = .convertFromSnakeCase fix not working
                let response = try decoder.decode(Response.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(.unknownError(error.localizedDescription)))
            }
        }.resume()
    }
}