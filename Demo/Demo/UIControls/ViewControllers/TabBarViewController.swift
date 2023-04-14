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
//        let settingVC = TableViewController(nibName: nil, bundle: nil)
//        self.setViewControllers([settingVC], animated: true)
//        self.selectedIndex = 0

        // set color as selected background color
        let numberOfItems = CGFloat(tabBar.items?.count ?? 1)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems - 20, height: 90)
        tabBar.selectionIndicatorImage = UIImage(named: "cyan_bg")?.resizedImage(to: tabBarItemSize)
        
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("selecting: \(viewController.title)")
        print("selecting: \(tabBarController.selectedIndex)")
        return true
    }
}
