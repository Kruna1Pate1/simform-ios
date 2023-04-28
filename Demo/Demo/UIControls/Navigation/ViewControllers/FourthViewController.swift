//
//  FourthViewController.swift
//  Demo
//
//  Created by Krunal Patel on 24/04/23.
//

import UIKit

class FourthViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tfName: UITextField!
    
    // MARK: - Variables
    var name: String?
    weak var delegate: DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = name
    }
    
    @IBAction func goToFifthVC(sender: UIButton) {
        if let fifthVC = storyboard?.instantiateViewController(withIdentifier: "FifthVC") as? FifthViewController {
            fifthVC.name = tfName.text
            fifthVC.delegate = self
            present(fifthVC, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        delegate?.getValue(tfName.text)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getValue(tfName.text)
    }
}

extension FourthViewController: DataDelegate {
    func getValue(_ value: String?) {
        tfName.text = value
    }
}
