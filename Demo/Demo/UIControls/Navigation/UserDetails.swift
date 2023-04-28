//
//  UserDetails.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import Foundation

class UserDetails {
   
    // MARK: - Private Constants
    private static let userDefaults = UserDefaults.standard
    
    private init() { }
    
    // MARK: - Static Methods
    static func saveDetails(username: String) {
        userDefaults.setValue(username, forKey: Keys.username)
        userDefaults.setValue(UUID().uuidString, forKey: Keys.authToken)
    }
    
    static func removeAuthDetails() {
        userDefaults.removeObject(forKey: Keys.authToken)
    }
    
    static func isLoggedIn() -> Bool {
        return userDefaults.string(forKey: Keys.authToken) != nil
    }
    
    static func getUsername() -> String {
        return userDefaults.string(forKey: Keys.username) ?? ""
    }
    
    // MARK: - Keys
    struct Keys {
        static let username = "Username"
        static let authToken = "AuthToken"
    }
}
