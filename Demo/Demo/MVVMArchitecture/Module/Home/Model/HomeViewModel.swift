//
//  HomeViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

class HomeViewModel {
    
    var email = Dynamic<String>("")
    
    func setEmail(email: String) {
        self.email.value = email
    }
}
