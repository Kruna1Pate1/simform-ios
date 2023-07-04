//
//  AuthVC.swift
//  Demo
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

class AuthVC: UIViewController, Storyboarded {
    
    // MARK: - Vars & Lets
    private var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.error.bind { [weak self] error in
            self?.showAlert(title: "Login Error", message: error)
        }
    }
    
    // MARK: - IBActions
    @IBAction func actionSignin(_ sender: UIButton) {
        viewModel.signIn()
    }
}
