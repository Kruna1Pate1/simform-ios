//
//  NCOneViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/06/23.
//

import UIKit

class NCTwoViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var txtMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessage(_:)), name: .message, object: nil)
    
    }
    
    @objc
    private func updateMessage(_ notification: Notification) {
        if let message = (notification.userInfo?[Notification.Name.message.rawValue] as? String) {
            txtMessage.text = message
        }
    }
}
