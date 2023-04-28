//
//  Coordinator.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    init(navigationController: UINavigationController)

    func start()
    
    func finish()
    
    func finishToRoot()
}
