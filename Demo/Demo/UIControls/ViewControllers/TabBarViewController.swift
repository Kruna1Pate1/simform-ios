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
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: .cyan.withAlphaComponent(0.4), size: tabBarItemSize)

        // remove default border
        tabBar.frame.size.width = self.view.frame.width + 4
        
        
        tabBar.frame.origin.x = -2
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("selecting: \(viewController.title)")
        print("selecting: \(tabBarController.selectedIndex)")
        return true
    }
}



extension UIImage {

    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

}
