//
//  AFSLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit

class AFSLoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var txtPassword: MyTextField!
    
    private let viewModel = AFSLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindSignInUI()
    }
    
    
    // MARK: - Methods
    private func setupUI() {
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
    }
    
    private func bindViewModel() {
        viewModel.errorMessage.bind { message in
            self.showAlert(title: "Login failed", message: message)
        }
    }
    
    private func bindSignInUI() {
        viewModel.loginSuccess.bind { token in
            self.showAlert(title: "Login successful", message: "Token: \(token)")
        }
    }
    
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        viewModel.validateData(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
    }
}
