//
//  ViperHomeVC.swift
//  Demo
//
//  Created by Krunal Patel on 21/06/23.
//

import UIKit

class ViperHomeVC: UIViewController, Storyboarded {

    // MARK: - Outlets
    @IBOutlet private weak var txtEmail: UILabel!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        txtEmail.text = email
    }
}
