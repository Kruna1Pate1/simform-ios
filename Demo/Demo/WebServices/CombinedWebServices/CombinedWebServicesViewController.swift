//
//  CombinedWebServicesViewController.swift
//  Demo
//
//  Created by Krunal Patel on 19/06/23.
//

import UIKit

class CombinedWebServicesViewController: UIViewController {
    
    // MARK: - Outletes
    @IBOutlet private weak var tblComponents: UITableView!
    
    // MARK: - Vars & Lets
    private let componentCellName = "ComponentCell"
    private let components = Component.getComponents(type: .webService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tblComponents.sectionHeaderTopPadding = 0
        tblComponents.register(UINib(nibName: componentCellName, bundle: nil), forCellReuseIdentifier: componentCellName)
    }
    
}

// MARK: - Table View
extension CombinedWebServicesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: componentCellName, for: indexPath) as? ComponentCell {
            cell.lblTitle.text = components[indexPath.section].name
            return cell
        }
        return TableViewCell()
    }
}

extension CombinedWebServicesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = components[indexPath.section].viewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
