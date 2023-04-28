//
//  ProfileViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/04/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var tfTimeZone: MyTextField!
    @IBOutlet private weak var lblWelcome: UILabel!
    @IBOutlet private weak var timeZoneContainer: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = "Profile"
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        lblWelcome.text = "Welcome \(UserDetails.getUsername())"
        tfTimeZone.delegate = self
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let logoutItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        tabBarController?.navigationItem.rightBarButtonItem = logoutItem
        tabBarController?.navigationItem.hidesBackButton = true
    }
    
    private func showTimezones() {
        if let timeZoneVC = storyboard?.instantiateViewController(withIdentifier: "TimeZoneVC") as? TimeZonesViewController {
            timeZoneVC.delegate = self
            timeZoneVC.modalPresentationStyle = .popover
            timeZoneVC.preferredContentSize = CGSizeMake(view.bounds.width / 2, 800)
            timeZoneVC.isModalInPresentation = true
            
            if let popover = timeZoneVC.popoverPresentationController {
                popover.sourceView = tfTimeZone
                let frame = timeZoneContainer.frame
                popover.permittedArrowDirections = .up
                popover.delegate = self
            }
            tfTimeZone.rightImage = UIImage(named: "arrow-up")
            navigationController?.present(timeZoneVC, animated: true)
        }
    }
    
    @objc private func logout() {
        UserDetails.removeAuthDetails()
        
        let loginVC = UIStoryboard(name: "NavigationExercise", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        UIView.transition(from: view, to: loginVC.view, duration: 0.4, options: .transitionFlipFromLeft) { _ in
            self.navigationController?.popToRootViewController(animated: false)
            self.navigationController?.pushViewController(loginVC, animated: false)
        }
    }
}

// MARK: - Popover
extension ProfileViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        tfTimeZone.rightImage = UIImage(named: "arrow-down")
    }
}

// MARK: - Data Delegate
extension ProfileViewController: DataDelegate {
    func getValue(_ value: String?) {
        tfTimeZone.text = value
        tfTimeZone.rightImage = UIImage(named: "arrow-down")
    }
}

// MARK: - Text Field
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showTimezones()
        return false
    }
}
