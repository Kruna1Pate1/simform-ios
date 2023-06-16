//
//  AFSLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit

class AFSUpdateViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtName: MyTextField!
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var txtNumber: MyTextField!
    @IBOutlet private weak var txtContry: MyTextField!
    
    // MARK: - Vars & Lets
    private let viewModel = AFSUpdateViewModel()
    var userId: String = "55"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUserDetail()
        bindViewModel()
        bindUpdateUI()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        viewModel.getUser(userId: userId)
    }
    
    private func bindUserDetail() {
        viewModel.userDetails.bind { user in
            guard let user = user else { return }
            
            self.txtName.text = user.name
            self.txtEmail.text = user.email
            self.txtNumber.text = user.number
            self.txtContry.text = user.country
        }
    }
    
    private func bindViewModel() {
        viewModel.errorMessage.bind { message in
            self.showAlert(title: "Details update failed", message: message)
        }
    }
    
    private func bindUpdateUI() {
        viewModel.registerSuccess.bind { userId in
            self.showAlert(title: "Details updated successful", message: "Id: \(userId)") {
            }
        }
    }
    
    @IBAction func onUpdateClicked(_ sender: UIButton) {
        viewModel.validateData(userId: userId, name: txtName.text ?? "", email: txtEmail.text ?? "", number: txtNumber.text ?? "", country: txtContry.text ?? "")
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
