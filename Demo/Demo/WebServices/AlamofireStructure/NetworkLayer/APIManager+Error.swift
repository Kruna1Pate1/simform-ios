//
//  APIManager+Error.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Foundation


/// API Error
struct APIError {
    
    // MARK: Alerts
    static let defaultAlertTitle   = "warning"
    static let errorAlertTitle     = "error"
    static let genericErrorMessage = "Something went wrong, please try again."
    static let unprocessableEntity = "Unprocessable Entity"
    static let notFound            = "Not Found"
    static let parameterMissing    = "Missing Param"
    static let unAuthorizeUser     = "Authorisation Error"
    static let noInternet          = "No Internet Connection"
    static let noData              = "No data"
}

class CustomError: Error {
    
    // MARK: Vars & Lets
    var title = ""
    var body = ""
    
    // MARK: Intialization
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
}
