//
//  UserCellTableViewCell.swift
//  Demo
//
//  Created by Krunal Patel on 12/06/23.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Variables
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(user: User) {
        
        if let avtar = URL(string: user.avatar) {
            URLSession.shared.dataTask(with: avtar) { [weak imgProfile] (data, urlResponse, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        imgProfile?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        txtName.text = user.firstName + " " + user.lastName
        txtEmail.text = user.email
    }
}
