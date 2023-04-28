//
//  TimeZonesViewController.swift
//  Demo
//
//  Created by Krunal Patel on 27/04/23.
//

import UIKit

class TimeZonesViewController: UITableViewController {
    
    // MARK: - Variables
    weak var delegate: DataDelegate?
    private var timeZoneList = timeZones
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZoneCell") as? TimeZoneCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(timeZoneList[indexPath.row], image: UIImage(systemName: "map.circle.fill"))
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getValue(timeZoneList[indexPath.row])
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view =  Bundle.main.loadNibNamed("HeaderView", owner: self)?[0] as? HeaderView {
            view.searchBar.delegate = self
            return view
        }
        return nil
    }
}

// MARK: - Search Bar
extension TimeZonesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == true {
            timeZoneList = timeZones
        } else {
            timeZoneList = timeZones.filter { $0.contains(searchText) }
        }
        tableView.reloadData()
    }
}
