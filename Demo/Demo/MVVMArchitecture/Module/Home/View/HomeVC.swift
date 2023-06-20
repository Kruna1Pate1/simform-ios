//
//  HomeVC.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: UILabel!
    
    // MARK: - Vars & Lets
    var homeCoordinator: HomeCoordinator?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        if let email = homeCoordinator?.email {
            viewModel.setEmail(email: email)
        }
        let button = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = button
    }
    
    private func bindViewModel() {
        viewModel.email.bind { email in
            self.txtEmail.text = email
        }
    }
    
    @objc
    private func signOut() {
        UserManager.shared.authToken = nil
        UserManager.shared.email = nil
        homeCoordinator?.goToLogin()
    }
}
