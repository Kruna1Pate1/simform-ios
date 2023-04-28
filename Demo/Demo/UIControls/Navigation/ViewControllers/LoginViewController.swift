//
//  LoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/04/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tfUsername: MyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = "Login"
        tfUsername.text = UserDetails.getUsername()
    }
    
    private func updateScreen() {
        let combinedVC = UIStoryboard(name: "CombinedScreen", bundle: nil).instantiateViewController(withIdentifier: "CombinedVC")
        combinedVC.navigationItem.hidesBackButton = true
        UIView.transition(from: view, to: combinedVC.view, duration: 0.4, options: .transitionFlipFromRight) { _ in
            self.navigationController?.pushViewController(combinedVC, animated: false)
        }
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        UserDetails.saveDetails(username: tfUsername.text ?? "")
        updateScreen()
    }
}
