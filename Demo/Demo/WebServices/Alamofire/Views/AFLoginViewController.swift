//
//  AFLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import UIKit

class AFLoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var txtUsername: MyTextField!
    @IBOutlet private weak var txtPassword: MyTextField!
    
    private var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        viewModel = LoginViewModel()
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        container.layer.cornerRadius = 40
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = txtUsername.text, let password = txtPassword.text else { return }
        
        viewModel.login(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                switch result {
                case .success(let response):
                    guard let token = response.token else {
                        self.showAlert(title: "Login failed", message: "Invalid username or password")
                        return
                    }
                    self.showAlert(title: "Login successfull", message: "Token: \(token)") {
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AFProductVC") {
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                case .failure(let error):
                    self.showAlert(title: "Login failed", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String = "", completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
