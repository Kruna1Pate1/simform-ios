//
//  TabelViewController.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var settings: [String: [Setting]] = [
        "Network": Setting.dummySettings(for: "Network"),
        "Accessibility": Setting.dummySettings(for: "Accessibility"),
        "Security": Setting.dummySettings(for: "Security"),
        "Developer options": Setting.dummySettings(for: "Developer options"),
        "Language": Setting.dummySettings(for: "Language"),
        "Device info": Setting.dummySettings(for: "Device info")
    ]
    var languages: [LanguageModel] = LanguageModel.dummyLanguages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(UINib(nibName: "SwitchSettingCell", bundle: nil), forCellReuseIdentifier: "SwitchSettingCell")
        tableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
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
        if section == settings.count - 1 {
            return 1
        }
        
        let setting = settings[section]
        
        if setting.value.first?.expanded == false {
            return 1
        }
        
        if setting.key == "Language" {
            return languages.count + 1
        }
        return setting.value.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if settings[indexPath.section].key == "Device info" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell {
                cell.lblDescription.text = settings[indexPath.section].value[indexPath.row].description
                cell.expand = { isExpanded in
                    print("reload \(indexPath) \(isExpanded)")
//                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
                }
                return cell
            }
        }

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
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bellAction = UIContextualAction(style: .normal, title: "notify") { (action, view, completion) in
            completion(true)
        }
        bellAction.image = UIImage(systemName: "bell.slash")
        bellAction.backgroundColor = UIColor.brown
        if isLanguage(at: indexPath) {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
                print("deleting \(indexPath)")
                self.languages.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                completion(true)
            }
            deleteAction.image = UIImage(systemName: "trash.fill")
            deleteAction.backgroundColor = UIColor.systemRed
            
            return UISwipeActionsConfiguration(actions: [deleteAction, bellAction])
        }
        return UISwipeActionsConfiguration(actions: [bellAction])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return dynamic height
//        return UITableView.automaticDimension
        if settings[indexPath.section].key == "Device info" {
            return UITableView.automaticDimension
        }
        return 92
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
        if section == 1 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width - 20), height: 60))
            header.backgroundColor = .cyan
            let headerTitle = UILabel(frame: CGRect(x: 20, y: 0, width: Int(header.frame.width - 20), height: Int(header.frame.height)))
            headerTitle.text = settings[section].key
            header.addSubview(headerTitle)
            return header
        }
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
        if let expanded = settings[indexPath.section].value.first?.expanded {
            settings[indexPath.section].value[0].expanded = !expanded
            tableView.reloadData()
        }
        return nil
    }
}

private extension TableViewController {
    func isLanguage(at indexPath: IndexPath) -> Bool {
        indexPath.row != 0 && settings[indexPath.section].key == "Language"
    }
}
