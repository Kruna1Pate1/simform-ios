//
//  AuthenticationVC.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class LoginVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    
    // MARK: - Vars & Lets
    var authenticationCoordinator: AuthenticationCoordinator?
    private let viewModel = LoginViewModel2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.errorMessage.bind { error in
            self.showAlert(title: error)
        }
        
        viewModel.loginSuccess.bind { (email,  token) in
            UserManager.shared.email = email
            UserManager.shared.authToken = token
            self.authenticationCoordinator?.goToHome(email: email)
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        viewModel.validate(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
    }
    
    
    @IBAction func signupAction(_ sender: UIButton) {
        authenticationCoordinator?.goToSignUp()
    }
}
