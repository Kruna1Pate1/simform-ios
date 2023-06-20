//
//  Coordinator.swift
//  Demo
//
//  Created by Krunal Patel on 20/06/23.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
