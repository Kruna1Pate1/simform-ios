//
//  UserListViewController.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tblUsers: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        indicator.startAnimating()
        UserCodableApi.shared.getUsers { [weak self] (userList, error) in
            guard let self = self else { return }
            
            if let userList = userList {
                self.users = userList.users
                DispatchQueue.main.async {
                    self.tblUsers.reloadData()
                    self.indicator.stopAnimating()
                }
            }
        }
    }
}

// MARK: - Table View
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return TableViewCell()
        }
        cell.configCell(user: users[indexPath.row])
        
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserCodableApi.shared.deleteUser(userId: users[indexPath.row].id) { result in
                let title: String = "User delete"
                var message: String?
                switch result {
                case .success(let response):
                    if response.isSuccess == true {
                        message = "Use with id \(self.users[indexPath.row].id) deleted successfully"
                    } else {
                        message = "Can't delete user"
                    }
                case .failure(let error):
                    message = error.localizedDescription
                }
                
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default) {_ in
                        alertController.dismiss(animated: true)
                    })
                    self.present(alertController, animated: true)
                    self.users.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}
