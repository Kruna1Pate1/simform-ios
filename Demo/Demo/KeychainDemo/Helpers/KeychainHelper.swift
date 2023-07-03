//
//  KeychainHelper.swift
//  Demo
//
//  Created by Krunal Patel on 03/07/23.
//

import Foundation
import SwiftKeychainWrapper

class KeychainHelper {
    
    // MARK: - Private initializer
    private init() {
        KeychainWrapper.standard[.passcode] = "123456"
    }
    
    // MARK: - Vars & Lets
    private let keychain = KeychainWrapper.standard
    static let shared = KeychainHelper()
    
    var secretText: String? {
        get {
            keychain[.secretText]
        } set {
            keychain[.secretText] = newValue
        }
    }
    
    var passcode: String? {
        get {
            keychain[.passcode]
        } set {
            keychain[.passcode] = newValue
        }
    }
}

// MARK: - Keys
extension KeychainWrapper.Key {
    static let secretText: KeychainWrapper.Key = "secretText"
    static let passcode: KeychainWrapper.Key = "passcode"
}
