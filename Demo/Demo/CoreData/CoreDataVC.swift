//
//  CoreDataVC.swift
//  Demo
//
//  Created by Krunal Patel on 27/07/23.
//

import UIKit
import CoreData

class CoreDataVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtName: UITextField!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet private weak var txtContactNumber: UITextField!
    
    // MARK: - Vars & Lets
    //We need to create a context from this container
    private let managedContext: NSManagedObjectContext! =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    private func saveUser(name: String, email: String, password: String, contact: String) {
        guard let userEntity = NSEntityDescription.entity(forEntityName: "UserItem", in: managedContext) else { return }
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(UUID(), forKey: "id")
        user.setValue(name, forKey: "name")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        user.setValue(contact, forKey: "contactNumber")
        user.setValue(true, forKey: "active")
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Couldn't save: \(error)")
        }
    }
    
    // MARK: - IBActions
    @IBAction private func actionSaveUser(_ sender: Any) {
        saveUser(name: txtName.text ?? "",
                 email: txtEmail.text ?? "",
                 password: txtPassword.text ?? "",
                 contact: txtContactNumber.text ?? "")
    }
    
    
    @IBAction func goToViewUsers(_ sender: Any) {
        let vc = UIStoryboard(name: "CoreData", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}
