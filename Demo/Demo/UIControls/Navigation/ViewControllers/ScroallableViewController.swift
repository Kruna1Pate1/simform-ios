//
//  ScroallableViewController.swift
//  Demo
//
//  Created by Krunal Patel on 25/04/23.
//

import UIKit

class ScroallableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
    }
    
    @IBAction func goBack(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .systemBlue
    }
}

extension ScroallableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2) {
            if scrollView.contentOffset.y > 1 && self.navigationController?.navigationBar.prefersLargeTitles == true {
                self.navigationController?.navigationBar.prefersLargeTitles = false
            } else if scrollView.contentOffset.y < 1 && self.navigationController?.navigationBar.prefersLargeTitles == false {
                self.navigationController?.navigationBar.prefersLargeTitles = true
            }
        }
    }
}
