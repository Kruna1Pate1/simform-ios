//
//  PickerViewController.swift
//  Demo
//
//  Created by Krunal Patel on 13/04/23.
//

import UIKit

class PickerViewController: UIViewController {

    var stateData = StateModel.loadData(fromFile: "indian_cities")
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(stateData)
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
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 100
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return stateData[row].state
        }
        print(pickerView.selectedRow(inComponent: 0))
        return stateData[pickerView.selectedRow(inComponent: 0)].cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        print("Selecting: \(component):\(row)")
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let uiView = UIView(frame: CGRectMake(0, 0, 20, 20))
//        uiView.backgroundColor = .systemPink
//        return uiView
//    }
}
