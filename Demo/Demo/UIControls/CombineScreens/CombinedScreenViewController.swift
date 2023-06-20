//
//  CombinedScreenViewController.swift
//  Demo
//
//  Created by Krunal Patel on 19/04/23.
//

import UIKit

class CombinedScreenViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tblComponents: UITableView!
    @IBOutlet private weak var btnEdit: UIButton!
    
    // MARK: - Private Variables
    private let componentCellName = "ComponentCell"
    private var components = Component.getComponents(type: .uiComponent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        // Long press to reorder delegates lead to crash while reordering
//        tblComponents.dragDelegate = self
//        tblComponents.dropDelegate = self
        tblComponents.sectionHeaderTopPadding = 0
        registerCells()
    }
    
    private func registerCells() {
        tblComponents.register(UINib(nibName: componentCellName, bundle: nil), forCellReuseIdentifier: componentCellName)
    }
    
    @IBAction private func toogleEdit(_ sender: UIButton) {
        tblComponents.isEditing = sender.isSelected
        tblComponents.reloadData()
    }
}

// MARK: - Table View

extension CombinedScreenViewController: UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            components.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return btnEdit.isSelected
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = components.remove(at: sourceIndexPath.section)
        components.insert(temp, at: destinationIndexPath.section)
    }
}

extension CombinedScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return components[indexPath.section].name.contains("UILabel") ? 70 : 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, completion) in
            self.components.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        
        if indexPath.section == 0 {
            // Coordinator pattern
            let appCoordinator = AppCoordinator(navigationController: navigationController)
            UserManager.shared.sceneDelegate?.appCoordinator = appCoordinator
            appCoordinator.start()
        } else {
            let vc = components[indexPath.section].viewController
            vc.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(vc, animated: true)
        }
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

extension CombinedScreenViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        UIView.setAnimationsEnabled(false)
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: "Move" as NSItemProviderWriting))
        dragItem.localObject = components[indexPath.section]
        return [dragItem]
    }
}

extension CombinedScreenViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {
        UIView.setAnimationsEnabled(true)
    }
}
