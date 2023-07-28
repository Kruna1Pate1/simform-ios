//
//  CoreDataVC.swift
//  Demo
//
//  Created by Krunal Patel on 27/07/23.
//

import UIKit
import CoreData

class UpdateUserVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtName: UITextField!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet private weak var txtContactNumber: UITextField!
    @IBOutlet weak var btnActivate: UIButton!
    
    // MARK: - Vars & Lets
    var userItem: UserItem?
    var onDismiss: (() -> Void)?
    private let managedContext: NSManagedObjectContext! =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        if let user = userItem {
            txtName.text = user.name
            txtEmail.text = user.email
            txtPassword.text = user.password
            txtContactNumber.text = user.contactNumber
            btnActivate.isSelected = user.active
            btnActivate.backgroundColor = user.active ? .systemRed : .systemGreen
        }
    }
    
    
    private func saveUser(name: String, email: String, password: String, contact: String) {
        guard let user = userItem else { return }
        
        user.name = name
        user.email = email
        user.password = password
        user.contactNumber = contact
        
        do {
            try managedContext.save()
            dismiss(animated: true) { [weak self] in
                self?.onDismiss?()
            }
        } catch {
            debugPrint("Couldn't update: \(error)")
        }
    }
    
    // MARK: - IBActions
    @IBAction private func actionSaveUser(_ sender: UIButton) {
        saveUser(name: txtName.text ?? "",
                 email: txtEmail.text ?? "",
                 password: txtPassword.text ?? "",
                 contact: txtContactNumber.text ?? "")
    }
    
    @IBAction func actionToggleActivation(_ sender: UIButton) {
        userItem?.active = sender.isSelected
        
        do {
            try managedContext.save()
            dismiss(animated: true) { [weak self] in
                self?.onDismiss?()
            }
        } catch {
            debugPrint("Couldn't update: \(error)")
        }
    }
}
