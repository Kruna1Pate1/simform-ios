//
//  ViewController.swift
//  LifecycleDemo
//
//  Created by Krunal Patel on 16/02/23.
//

import UIKit

class ViewController: UIViewController {
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
    override func loadView() {
        super.loadView()
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    deinit {
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
    }

}

