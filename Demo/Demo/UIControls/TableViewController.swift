//
//  TabelViewController.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let settings: [String: [Setting]] = [
        "Network": Setting.dummySettings(for: "Network"),
        "Accessibility": Setting.dummySettings(for: "Accessibility"),
        "Security": Setting.dummySettings(for: "Security"),
        "Developer options": Setting.dummySettings(for: "Developer options"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        tableView.register(UINib(nibName: "SwitchSettingCell", bundle: nil), forCellReuseIdentifier: "switchedCell")
        
        tableView.rowHeight = 10
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("count: \(settings.flatMap { $0.value }.count)")
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].value.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\(indexPath.section), \(indexPath.row)")
        let setting = settings[indexPath.section].value[indexPath.row]
        if setting.isSwitched {
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchedCell", for: indexPath) as! SwitchSettingCell
            cell.lblTitle.text = setting.title
            cell.imgIcon.image = setting.icon?.resizedImage(to: 20)
            cell.switchEnable.isOn = setting.isSwitchOn
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
            cell.lblTitle.text = setting.title
            cell.imgIcon.image = setting.icon?.resizedImage(to: 20)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].key
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        []
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("[selected] section \(indexPath.section), row \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay \(indexPath.section), \(indexPath.row)")
    }
}

private extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
