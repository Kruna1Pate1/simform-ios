//
//  KeychainDemoViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 03/07/23.
//

import Foundation

class KeychainDemoViewModel {
    
    let errorMessage = Dynamic<String>("")
    let saveSuccessfully = Dynamic<Void>(())
    let loadSuccessfully = Dynamic<String>("")
    
    func validateAndSaveData(secret: String, passcode: String) {

        guard validatePasscode(passcode) else { return }
        KeychainHelper.shared.secretText = secret
        saveSuccessfully.fire()
    }
    
    
    func loadSecretText(passcode: String) {
        guard validatePasscode(passcode) else { return }
        
        loadSuccessfully.value = KeychainHelper.shared.secretText ?? ""
    }
    
    func validatePasscode(_ passcode: String) -> Bool {
        if passcode.isEmpty {
            errorMessage.value = "Passcode can't be empty"
            return false
        }
        
        if passcode != KeychainHelper.shared.passcode {
            errorMessage.value = "Invalid passcode"
            return false
        }
        return true
    }
}
