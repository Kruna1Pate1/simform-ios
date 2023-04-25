//
//  PickerViewController.swift
//  Demo
//
//  Created by Krunal Patel on 13/04/23.
//

import UIKit

class PickerViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var pickerView: UIPickerView!

    // MARK: - Private Variables
    
    private var stateData = StateModel.loadData(fromFile: "indian_cities")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return stateData.count
        } else {
            return stateData[pickerView.selectedRow(inComponent: 0)].cities.count
        }
    }
}

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return stateData[row].state
        }
        return stateData[pickerView.selectedRow(inComponent: 0)].cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
