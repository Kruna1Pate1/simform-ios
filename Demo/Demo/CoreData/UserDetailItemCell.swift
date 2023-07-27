//
//  UserDetailItemCell.swift
//  Demo
//
//  Created by Krunal Patel on 27/07/23.
//

import UIKit

class UserDetailItemCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtId: UILabel!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtPassword: UILabel!
    @IBOutlet private weak var txtEmail: UILabel!
    @IBOutlet private weak var txtContact: UILabel!
    @IBOutlet private weak var containerView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    func configCell(user: UserItem) {
        txtId.text = user.id?.uuidString
        txtName.text = user.name
        txtPassword.text = user.password
        txtEmail.text = user.email
        txtContact.text = user.contactNumber
        containerView.backgroundColor = user.active ? .white : .gray
    }
}
