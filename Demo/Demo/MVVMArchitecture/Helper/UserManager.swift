//
//  UserManager.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

struct Keys {
    static let authToken = "authToken"
    static let email = "email"
}

class UserManager {
    
    private init() {}
    
    static let shared: UserManager = UserManager()
    let userDefaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        return userDefaults.string(forKey: Keys.authToken) != nil
    }
    
    var authToken: String? {
        get {
            userDefaults.string(forKey: Keys.authToken)
        } set {
            userDefaults.setValue(newValue, forKey: Keys.authToken)
        }
    }
    
    var email: String? {
        get {
            userDefaults.string(forKey: Keys.email)
        } set {
            userDefaults.setValue(newValue, forKey: Keys.email)
        }
    }
    
    var sceneDelegate: SceneDelegate? {
        UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
}
