//
//  UIVIewController+extentions.swift
//  Demo
//
//  Created by Krunal Patel on 19/06/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String = "", completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
