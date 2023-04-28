//
//  FifthViewController.swift
//  Demo
//
//  Created by Krunal Patel on 25/04/23.
//

import UIKit

class FifthViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tfName: UITextField!
    
    // MARK: - Variables
    var name: String?
    weak var delegate: DataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = name
    }
    
    @IBAction func dismissAll(sender: UIButton) {
        view.window?.rootViewController?.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getValue(tfName.text)
    }
}
