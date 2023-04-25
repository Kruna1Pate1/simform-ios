//
//  DynamicTextViewController.swift
//  Demo
//
//  Created by Krunal Patel on 24/04/23.
//

import UIKit

class DynamicTextViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tvDynamic: MyTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style:   UIBarButtonItem.Style.done, target: self, action: #selector(hideKeyboard))
        toolbar.setItems([.flexibleSpace(), donebutton], animated: false)
        tvDynamic.inputAccessoryView = toolbar
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
