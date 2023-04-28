//
//  ThirdViewController.swift
//  Demo
//
//  Created by Krunal Patel on 24/04/23.
//

import UIKit

class ThirdViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var tfName: UITextField!
    
    // MARK: - Variables
    var name: String?
    weak var delegate: DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = name
    }
    
    // prepare not called
    @IBAction func goToFourthVC(sender: UIButton) {
        guard let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthVC") as? FourthViewController else { return }
        fourthVC.modalPresentationStyle = .formSheet
        fourthVC.preferredContentSize = CGSizeMake(view.frame.width, view.frame.height)
        if let sheet = fourthVC.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.prefersGrabberVisible = true
        }
        fourthVC.name = tfName.text
        fourthVC.delegate = self
        present(fourthVC, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.getValue(tfName.text)
    }
}


extension ThirdViewController: DataDelegate {
    func getValue(_ value: String?) {
        tfName.text = value
    }
}
