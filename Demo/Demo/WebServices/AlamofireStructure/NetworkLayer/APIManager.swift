//
//  APIManager.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit
import Alamofire

class APIManager {
    
    // MARK: Vars & Lets
    private let sessionManager: Session
    
    static var shared: APIManager {
        return APIManager()
    }
    
    func call<T>(type: RequestItemsType, params: Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        
        sessionManager.request(type.url,
                               method: type.httpMethod,
                               parameters: params,
                               encoding: type.encoding).validate().responseData { (data) in
            if self.handleResponseCode(res: data) {
                do {
                    guard let jsonData = data.data else {
                        throw CustomError(title: APIError.errorAlertTitle, body: APIError.noData)
                    }
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try jsonDecoder.decode(T.self, from: jsonData)
                    handler(.success(result))
                } catch {
                    if let error = error as? CustomError {
                        return handler(.failure(error))
                    }
                    handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)))
                }
            } else {
                handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.unAuthorizeUser)))
            }
        }
    }
    
    /// Handle response code
    ///
    /// - Parameter res: api response
    /// - Returns: returns true if response status is sucess else false
    private func handleResponseCode(res: AFDataResponse<Data>?) -> Bool {
        var isSuccess: Bool = false
        
        guard let dataResponse = res else {
            return isSuccess
        }
        guard let response = dataResponse.response else {
            return isSuccess
        }
        
        switch response.statusCode {
        case 200...300:
            isSuccess = true
        default: break
        }
        
        return isSuccess
    }
    
    // MARK: Initialization
    
    init() {
        self.sessionManager = Session()
    }
}
