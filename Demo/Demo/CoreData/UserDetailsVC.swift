//
//  CoreDataVC.swift
//  Demo
//
//  Created by Krunal Patel on 27/07/23.
//

import UIKit
import CoreData

class UserDetailsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tblUsers: UITableView!
    
    // MARK: - Vars & Lets
    private var userDetails = [UserItem]()
    //We need to create a context from this container
    private let managedContext: NSManagedObjectContext! =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retriveUsers()
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
    
    private func retriveUsers() {
        do {
            let result = try managedContext.fetch(UserItem.fetchRequest())
            userDetails.append(contentsOf: result)
            
            DispatchQueue.main.async { [weak self] in
                self?.tblUsers.reloadData()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    private func deleteUser(user: UserItem) {
        managedContext.delete(user)
    }
}

// MARK: - Table View
extension UserDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailItemCell") as? UserDetailItemCell else { return UITableViewCell() }
        
        cell.configCell(user: userDetails[indexPath.row])
        return cell
    }
}

extension UserDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteUser(user: userDetails[indexPath.row])
            userDetails.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UpdateUserVC") as? UpdateUserVC {
            vc.userItem = userDetails[indexPath.row]
            vc.onDismiss = {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            navigationController?.present(vc, animated: true)
        }
    }
}
