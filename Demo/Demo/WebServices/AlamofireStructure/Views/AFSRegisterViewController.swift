//
//  AFSLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit

class AFSRegisterViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var txtName: MyTextField!
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var txtNumber: MyTextField!
    @IBOutlet private weak var txtContry: MyTextField!
    
    private let viewModel = AFSRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindRegisterUI()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.errorMessage.bind { message in
            self.showAlert(title: "Registration failed", message: message)
        }
    }
    
    private func bindRegisterUI() {
        viewModel.registerSuccess.bind { userId in
            self.showAlert(title: "Login successful", message: "Id: \(userId)") {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AFSUpdateVC") as? AFSUpdateViewController {
                    vc.userId = userId
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func onRegisterClicked(_ sender: UIButton) {
        viewModel.validateData(name: txtName.text ?? "", email: txtEmail.text ?? "", number: txtNumber.text ?? "", country: txtContry.text ?? "")
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
