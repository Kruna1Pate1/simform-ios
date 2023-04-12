//
//  TabBarViewController.swift
//  Demo
//
//  Created by Krunal Patel on 12/04/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.delegate = self
        let settingVC = TableViewController(nibName: nil, bundle: nil)
        self.setViewControllers([settingVC], animated: true)
        self.selectedIndex = 0
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("selecting: \(viewController.title)")
        print("selecting: \(tabBarController.selectedIndex)")
        return .random()
    }
}
