//
//  NCThreeViewController.swift
//  Demo
//
//  Created by Krunal Patel on 26/06/23.
//

import UIKit

class NCThreeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    @IBAction func notifyMessage(_ sender: UIButton) {
        NotificationCenter.default.post(name: .message, object: self, userInfo: [Notification.Name.message.rawValue: txtMessage.text])
    }
    
}
