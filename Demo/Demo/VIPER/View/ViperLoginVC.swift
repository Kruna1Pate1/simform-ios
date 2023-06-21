//
//  ViperLoginVC.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class ViperLoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtEmail: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    
    // MARK: - Vars & Lets
    private var presenter: ViperLoginPresenter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods    
    private func setupUI() {
        if let navigationController = navigationController {
            presenter = ViperLoginPresenter(navigationController: navigationController)
        }
        presenter?.delegate = self
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        presenter?.validate(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
    }
}

// MARK: - Login
extension ViperLoginVC: ViperLoginDelegate {
    func login(didSuccessWith response: ViperLoginResponse) {
        if let token = response.token {
            showAlert(title: "Login Successful", message: "token: \(token)")
        }
    }
    
    func login(didFailedWith error: String) {
        showAlert(title: "Login failed", message: error)
    }
}

