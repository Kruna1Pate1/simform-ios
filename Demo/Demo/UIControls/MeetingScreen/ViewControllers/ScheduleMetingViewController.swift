//
//  ScheduleMetingViewController.swift
//  Demo
//
//  Created by Krunal Patel on 18/04/23.
//

import UIKit

class ScheduleMetingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var meetingTitleTextField: MyTextField!
    @IBOutlet private weak var descriptionTextView: MyTextView!
    @IBOutlet private weak var dateTextField: MyTextField!
    @IBOutlet private weak var timeTextField: MyTextField!
    @IBOutlet private weak var timezoneTextField: MyTextField!
    @IBOutlet weak var timezonePicker: UIPickerView!
    @IBOutlet private weak var durationTextField: MyTextField!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet private weak var reminderTextField: MyTextField!
    @IBOutlet weak var reminderPicker: UIDatePicker!
    @IBOutlet private weak var requiredPasswordSwitch: UISwitch!
    @IBOutlet private weak var passwordTextField: MyTextField!
    @IBOutlet private weak var emailTextField: MyTextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var meetingPaswordContainer: UIStackView!
    @IBOutlet weak var attendeesStackView: UIStackView!
    
    // MARK: Private constants
    private let dateFormat = "dd/MM/yyyy"
    private let timeFormat = "hh:mm a"
    private let maxDescriptionCharacters = 50
    private let maxProfiles = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerNotifications()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        setupTextFields()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style:   UIBarButtonItem.Style.done, target: self, action: #selector(hideKeyboard))
        toolbar.setItems([.flexibleSpace(), donebutton], animated: false)
        descriptionTextView.inputAccessoryView = toolbar
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .lightGray
    }
    
    private func setupTextFields() {
        let datePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, dateTextField.bounds.height))
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        self.dateTextField.insertSubview(datePicker, at: 0)
        dateTextField.text = datePicker.date.formatted(format: dateFormat)
        
        
        let timePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, timeTextField.bounds.height))
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        self.timeTextField.insertSubview(timePicker, at: 0)
        timeTextField.text = timePicker.date.formatted(format: timeFormat)
        
        timezonePicker.isHidden = true
        durationPicker.isHidden = true
        reminderPicker.isHidden = true
        
        timezoneTextField.text = timeZones[timezonePicker.selectedRow(inComponent: 0)]
        durationTextField.text = durationPicker.countDownDuration.formatted()
        reminderTextField.text = "\(reminderPicker.countDownDuration.formatted(units: [.minute])) before"
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func checkRequiredFields() -> Bool {
        if meetingTitleTextField.text?.isEmpty == true {
            print("\(meetingTitleTextField) is required")
            return false
        }
        else if dateTextField.text?.isEmpty == true {
            print("\(dateTextField) is required")
            return false
        }
        else if timeTextField.text?.isEmpty == true {
            print("\(timeTextField) is required")
            return false
        }
        else if timezoneTextField.text?.isEmpty == true {
            print("\(timezoneTextField) is required")
            return false
        }
        else if durationTextField.text?.isEmpty == true {
            print("\(durationTextField) is required")
            return false
        } else if requiredPasswordSwitch.isOn && passwordTextField.text?.isEmpty == true {
            print("\(passwordTextField) is required")
            return false
        } else if attendeesStackView.arrangedSubviews.count < 1 {
            print("attendees is required")
            return false
        }
        return true
    }
    
    private func addUser(email: String?) {
        if attendeesStackView.arrangedSubviews.count == maxProfiles - 1 {
            let view = UIView(frame: CGRectMake(0, 0, 40, 40))
            view.clipsToBounds = true
            view.layer.cornerRadius = view.bounds.height / 2
            let label = UILabel()
            view.backgroundColor = .blue
            label.backgroundColor = .blue
            label.textColor = .white
            label.text = "\(maxProfiles)+"
            view.addSubview(label)
            //            attendeesStackView.addArrangedSubview(view)
            //            attendeesStackView.insertArrangedSubview(view, at: attendeesStackView.arrangedSubviews.count)
            print(attendeesStackView.arrangedSubviews.count)
        } else if  attendeesStackView.arrangedSubviews.count < maxProfiles {
            let imageView = UIImageView(image: .randomProfileImage()?.resizedImage(to: 40))
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            attendeesStackView.addArrangedSubview(imageView)
        }
        emailTextField.text = ""
    }
    
    private func updateSubmitButton() {
        saveButton.backgroundColor = checkRequiredFields() ? UIColor(named: "cyan") : .lightGray
        saveButton.isEnabled = checkRequiredFields()
    }
    
    @IBAction func changeDuration(_ sender: UIDatePicker) {
        if sender.countDownDuration > (60 * 60 * 8) {
            sender.countDownDuration = 60 * 60 * 8
        }
        durationTextField.text = sender.countDownDuration.formatted()
        durationPicker.isHidden = true
    }
    
    @IBAction func changeReminder(_ sender: UIDatePicker) {
        if sender.countDownDuration > (60 * 60) {
            sender.countDownDuration = 60 * 60
        }
        reminderTextField.text = "\(sender.countDownDuration.formatted(units: [.minute])) before"
    }
    
    @objc func changeDate(_ sender: UIDatePicker) {
        dateTextField.text = sender.date.formatted(format: dateFormat)
    }
    
    @objc func changeTime(_ sender: UIDatePicker) {
        if sender.date < Date() {
            sender.date = Date()
        }
        timeTextField.text = sender.date.formatted(format: timeFormat)
    }
    
    
    @IBAction func addUserClick(_ sender: UIButton) {
        if isValidEmail(emailTextField.text) {
            addUser(email: emailTextField.text)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        showToast(message: "Saved successfully", backgroundColor: .systemBlue)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.size.height + 20
            scrollView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func changePasswordVisibility(_ sender: UISwitch) {
        meetingPaswordContainer.isHidden = !sender.isOn
    }
}

// MARK: - TextField
extension ScheduleMetingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        
        if textField == emailTextField {
            addUser(email: textField.text)
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case dateTextField:
            return false
        case timeTextField:
            return false
        case timezoneTextField:
            timezonePicker.isHidden.toggle()
            durationPicker.isHidden = true
            return false
        case durationTextField:
            durationPicker.isHidden.toggle()
            timezonePicker.isHidden = true
            return false
        case reminderTextField:
            reminderPicker.isHidden.toggle()
            return false
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            print(string)
            if string == "," || string == " " {
                if isValidEmail(emailTextField.text) {
                    addUser(email: textField.text)
                } else {
                    print("invalid email")
                    showToast(message: "Invalid Email")
                }
                return false
            }
        }
        return true
    }
}

// MARK: - TextView
extension ScheduleMetingViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < maxDescriptionCharacters
    }
}

// MARK: - PickerView
extension ScheduleMetingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeZones.count
    }
}

extension ScheduleMetingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeZones[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timezoneTextField.text = timeZones[row]
        pickerView.isHidden = true
    }
}
