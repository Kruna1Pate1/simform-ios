//
//  MySegue.swift
//  Demo
//
//  Created by Krunal Patel on 26/04/23.
//

import UIKit

class MySegue: UIStoryboardSegue {

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
    }

    override func perform() {
        if let sourceView = source.view, let destinationView = destination.view {
            
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            destinationView.frame = CGRectMake(0, screenHeight, screenWidth, screenHeight)
            let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow
            window?.insertSubview(destinationView, aboveSubview: sourceView)
            
            UIView.animate(withDuration: 0.4) {
                sourceView.frame = sourceView.frame.offsetBy(dx: 0, dy: -screenHeight)
                destinationView.frame = sourceView.frame.offsetBy(dx: 0, dy: -screenHeight)
            } completion: { finish in
                self.source.navigationController?.pushViewController(self.destination, animated: false)
            }
        }
    }
}
