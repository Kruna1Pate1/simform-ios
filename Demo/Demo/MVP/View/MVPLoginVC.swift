//
//  MVPLoginVC.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class MVPLoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    
    
    // MARK: - Vars & Lets
    private let presenter = MVPLoginPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        presenter.validate(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
    }
}

// MARK: - Login
extension MVPLoginVC: LoginDelegate {
    func login(didSuccessWith response: MVPLoginResponse) {
        if let token = response.token {
            showAlert(title: "Login Successful", message: "token: \(token)")
        }
    }
    
    func login(didFailedWith error: String) {
        showAlert(title: "Login failed", message: error)
    }
}
