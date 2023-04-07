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
        "Language": Setting.dummySettings(for: "Language"),
    ]
    var languages: [LanguageModel] = LanguageModel.dummyLanguages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(UINib(nibName: "SwitchSettingCell", bundle: nil), forCellReuseIdentifier: "SwitchSettingCell")
        tableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
        
        tableView.rowHeight = 10
        
        setupUI()
    }
    
    private func setupUI() {
        setupHeaderAndFooter()
    }
    
    private func setupHeaderAndFooter() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width - 20), height: 60))
        header.backgroundColor = .white
        let headerTitle = UILabel(frame: CGRect(x: 20, y: 0, width: Int(header.frame.width - 20), height: Int(header.frame.height)))
        headerTitle.text = "System"
        headerTitle.font = UIFont(descriptor: headerTitle.font.fontDescriptor, size: 20)
        header.addSubview(headerTitle)
        tableView.tableHeaderView = header
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width), height: 50))
        footer.backgroundColor = .lightGray
        let footerTitle = UILabel(frame: CGRect(x: 20, y: 0, width: Int(header.frame.width), height: Int(header.frame.height - 10)))
        footerTitle.text = "Developed with \u{1F496} by Krunal"
        footer.addSubview(footerTitle)
        tableView.tableFooterView = footer
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if settings[section].key == "Language" {
            return languages.count + 1
        }
        return settings[section].value.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\(indexPath.section), \(indexPath.row)")

        if isLanguage(at: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            let language = languages[indexPath.row - 1]
            cell.lblTitle.text = language.name
            
            if language.isSelected {
                cell.btnSelection.isSelected = true
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            
            return cell
        }
        
        let setting = settings[indexPath.section].value[indexPath.row]
        
        if setting.isSwitched {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchSettingCell", for: indexPath) as! SwitchSettingCell
            cell.lblTitle.text = setting.title
            cell.imgIcon.image = setting.icon?.resizedImage(to: 16)
            cell.switchEnable.isOn = setting.isSwitchOn
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.lblTitle.text = setting.title
            cell.imgIcon.image = setting.icon?.resizedImage(to: 16)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleting \(indexPath)")
            if isLanguage(at: indexPath) {
                languages.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return dynamic height
//        return UITableView.automaticDimension
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].key
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        []
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("[selected] section \(indexPath.section), row \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay \(indexPath.section), \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width), height: 40))
        let footerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: Int(footer.frame.width), height: Int(footer.frame.height - 10)))
        let text = NSMutableAttributedString(string: "more on \(settings[section].key)...")
        text.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 8, length: settings[section].key.count))
        footerTitle.attributedText = text
        footerTitle.textAlignment = NSTextAlignment.right
        footer.addSubview(footerTitle)
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: footer.frame.height - 1, width: footer.frame.width, height: 1)
        border.backgroundColor = UIColor.blue.cgColor
        footer.layer.addSublayer(border)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if isLanguage(at: indexPath) {
            print("deselect \(indexPath)")
            if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
                cell.btnSelection.isSelected = false
                languages[indexPath.row - 1].isSelected = false
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if isLanguage(at: indexPath) {
            print("select \(indexPath)")
            if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
                cell.btnSelection.isSelected = true
            }
            return indexPath
        }
        return nil
    }
}

private extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}

private extension TableViewController {
    func isLanguage(at indexPath: IndexPath) -> Bool {
        indexPath.row != 0 && settings[indexPath.section].key == "Language"
    }
}
