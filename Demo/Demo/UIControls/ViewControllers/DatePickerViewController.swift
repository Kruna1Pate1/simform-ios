//
//  DatePickerViewController.swift
//  Demo
//
//  Created by Krunal Patel on 13/04/23.
//

import UIKit

class DatePickerViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    // MARK: - Private Constants
    
    private let modes: [UIDatePicker.Mode] = [.countDownTimer, .date, .time, .dateAndTime]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.datePickerMode = .countDownTimer
        datePicker.countDownDuration = 10
    }
    
    @IBAction func dateChange(_ sender: UIDatePicker) {
        print(sender.date)
        print(sender.countDownDuration)
    }
}

// MARK: - Date Picker

extension DatePickerViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 4 : modes[pickerView.selectedRow(inComponent: 0)].availableStyles.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
}

extension DatePickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return modes[row].name
        } else {
            return modes[pickerView.selectedRow(inComponent: 0)].availableStyles[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let availableStyles = modes[pickerView.selectedRow(inComponent: 0)].availableStyles
            if !availableStyles.contains(datePicker.datePickerStyle) {
                datePicker.preferredDatePickerStyle = availableStyles[0]
            }
            datePicker.datePickerMode = modes[row]
            pickerView.reloadComponent(1)
        } else {
            datePicker.preferredDatePickerStyle = modes[pickerView.selectedRow(inComponent: 0)].availableStyles[row]
        }
    }
}
