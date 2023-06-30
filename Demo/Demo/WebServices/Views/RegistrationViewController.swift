//
//  RegistrationViewController.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var txtPassword: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        guard let email = txtEmail.text, let password = txtPassword.text else {
            return
        }
        
        let userRegister = UserRegister(email: email, password: password)
        
        UserCodableApi.shared.registerUser(user: userRegister) { result in
            
            var title = ""
            var message = ""
            
            switch result {
            case .success(let response):
                title = "Registration successfull"
                message = "Token: " + response.token
            case .failure(let error):
                title = "Registration unsuccessfull"
                message = error.localizedDescription
            }
            
            DispatchQueue.main.async {
                let alertController  = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
                    alertController.dismiss(animated: true)
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
    }
}
