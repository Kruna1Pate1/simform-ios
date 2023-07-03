//
//  KeychainDemoVC.swift
//  Demo
//
//  Created by Krunal Patel on 03/07/23.
//

import UIKit

class KeychainDemoVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtSecretText: UITextField!
    @IBOutlet private weak var txtPasscode: UITextField!
    
    // MARK: - Vars & Lets
    private let viewModel = KeychainDemoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindSecretText()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: error)
        }
    }
    
    private func bindSecretText() {
        viewModel.loadSuccessfully.bind { [weak self] secretText in
            guard let self = self else { return }
            
            self.txtPasscode.text = ""
            self.txtSecretText.text = secretText
        }
        
        viewModel.saveSuccessfully.bind { [weak self] in
            guard let self = self else { return }
            
            self.txtSecretText.text = ""
            self.txtPasscode.text = ""
        }
    }
    
    // MARK: - IBActions
    @IBAction func actionSave(_ sender: UIButton) {
        viewModel.validateAndSaveData(secret: txtSecretText.text ?? "", passcode: txtPasscode.text ?? "")
    }
    
    @IBAction func actionLoad(_ sender: UIButton) {
        viewModel.loadSecretText(passcode: txtPasscode.text ?? "")
    }
}
