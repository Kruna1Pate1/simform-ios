//
//  ViewController.swift
//  Demo
//
//  Created by Krunal Patel on 14/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var incBtn: UIButton!
    @IBOutlet weak var decBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
        // Do any additional setup after loading the view.
        
        let initialVal = Bundle.main.infoDictionary?["InitialProgress"] as? Int
        updateCounter(initialVal ?? 50)
        
        let label = UILabel()
        view.addSubview(label)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        print("\(#function) State: \(UIApplication.shared.applicationState.toString())")
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
    
    @IBAction func reset(_ sender: UIButton) {
        updateCounter(0)
    }
    
    @IBAction func increment(_ sender: UIButton) {
        let value = (progressBar.progress * 100) + 1
        if(value > 100) { return }
        updateCounter(Int(value))
    }
    
    @IBAction func decrement(_ sender: UIButton) {
        let value = (progressBar.progress * 100) - 1
        print(value + 1000)
        if(value < 0) { return }
        updateCounter(Int(value))
    }
     
    func updateCounter(_ value: Int) {
        counterLbl.text = String(value)
        progressBar.progress = Float(value) / 100
    }
}

