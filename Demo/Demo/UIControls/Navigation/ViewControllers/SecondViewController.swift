//
//  SecondViewController.swift
//  Demo
//
//  Created by Krunal Patel on 24/04/23.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tfName: UITextField!
    
    // MARK: - Variables
    var name: String?
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToSecondVC(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thirdVC = segue.destination as? ThirdViewController {
            thirdVC.delegate = self
            thirdVC.name = tfName.text
        }
    }
}

extension SecondViewController: DataDelegate {
    func getValue(_ value: String?) {
        tfName.text = value
    }
}
