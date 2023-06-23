//
//  APIManager.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit
import Alamofire
import Reachability

class APIManager {
    
    // MARK: Vars & Lets
    let reachability = try? Reachability()
    private let sessionManager: Session
    static var shared: APIManager = APIManager()
    
    typealias ResponseHandeler<T> = ((Result<T, CustomError>) -> Void)
    
    func call<T>(type: RequestItemsType, params: Parameters? = nil, handler: @escaping ResponseHandeler<T>) where T: Codable {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        
        sessionManager.request(type.url,
                               method: type.httpMethod,
                               parameters: params,
                               encoding: type.encoding).validate().responseData { (data) in
            self.handleResponseData(data: data, handler: handler)
        }
    }
    
    func callUpload<T>(type: RequestItemsType, data: Data, params: [String: String]? = nil, fileName: String = "image", progressHandler: @escaping ((_ pregress: Float) -> Void), responseHandler: @escaping ResponseHandeler<T>) where T: Codable {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            responseHandler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        
        sessionManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data,
                                         withName: "image",
                                         fileName: "\(fileName).jpeg", mimeType: "image/jpeg"
                )
                if let params = params {
                    for param in params {
                        let value = param.value.data(using: String.Encoding.utf8)!
                        multipartFormData.append(value, withName: param.key)
                    }
                }
            },
            to: type.url,
            method: type.httpMethod
        )
        .uploadProgress { progress in
            progressHandler(Float(progress.fractionCompleted))
        }
        .validate().responseData { (data) in
            self.handleResponseData(data: data, handler: responseHandler)
        }
    }
    
    func callLoadImage(type: RequestItemsType, params: Parameters? = nil, handler: @escaping ResponseHandeler<UIImage>) {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        
        sessionManager.request(type.url,
                               method: type.httpMethod,
                               parameters: params,
                               encoding: type.encoding).validate().responseData { (data) in
            guard let imageData = data.data, let image = UIImage(data: imageData) else {
                handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.unprocessableEntity)))
                return
            }
            handler(.success(image))
        }
    }
    
    func callDownload(type: RequestItemsType, destination: @escaping DownloadRequest.Destination, params: Parameters? = nil, progressHandler: @escaping ((_ progress: Float) -> Void), responseHandler: @escaping ResponseHandeler<Void>) {
        guard reachability?.connection ?? .unavailable != .unavailable else {
            responseHandler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        
        sessionManager.download(type.url,
                                method: type.httpMethod,
                                parameters: params,
                                encoding: type.encoding, to: destination)
        .downloadProgress { progress in
            progressHandler(Float(progress.fractionCompleted))
        }
        .validate().response { response in
            guard response.error == nil else {
                responseHandler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.unprocessableEntity)))
                return
            }
            responseHandler(.success(()))
        }
    }
    
    private func handleResponseData<T>(data: AFDataResponse<Data>, handler: ResponseHandeler<T>) where T: Codable {
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
