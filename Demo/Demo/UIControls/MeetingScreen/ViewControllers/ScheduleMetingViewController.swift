//
//  ScheduleMetingViewController.swift
//  Demo
//
//  Created by Krunal Patel on 18/04/23.
//

import UIKit

    
class ScheduleMetingViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var meetingTitleTextField: MyTextField!
    @IBOutlet private weak var descriptionTextView: MyTextView!
    @IBOutlet private weak var dateTextField: MyTextField!
    @IBOutlet private weak var timeTextField: MyTextField!
    @IBOutlet private weak var timezoneTextField: MyTextField!
    @IBOutlet private weak var durationTextField: MyTextField!
    @IBOutlet private weak var reminderTextField: MyTextField!
    @IBOutlet private weak var requiredPasswordSwitch: UISwitch!
    @IBOutlet private weak var passwordTextField: MyTextField!
    @IBOutlet private weak var emailTextField: MyTextField!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var meetingPaswordContainer: UIStackView!
    @IBOutlet private weak var attendeesStackView: UIStackView!
    
    // MARK: - Private constants
    private let dateFormat = "dd/MM/yyyy"
    private let timeFormat = "hh:mm a"
    private let maxDescriptionCharacters = 50
    private let maxProfiles = 5
    private let reminders = ["15 minutes before", "30 minutes before", "45 minutes before", "60 minutes before"]
    private var profileCount = 1
    
    // MARK: - Private variables
    private var reminderPicker: UIPickerView = UIPickerView()
    private var timezonePicker: UIPickerView = UIPickerView()
    
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
        timezoneTextField.inputAccessoryView = toolbar
        durationTextField.inputAccessoryView = toolbar
        reminderTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 10
        saveButton.layer.opacity = 0.5
    }
    
    private func setupTextFields() {
        let datePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, dateTextField.bounds.height))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        self.dateTextField.insertSubview(datePicker, at: 0)
        dateTextField.text = datePicker.date.formatted(format: dateFormat)
        
        
        let timePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, timeTextField.bounds.height))
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        self.timeTextField.insertSubview(timePicker, at: 0)
        timeTextField.text = timePicker.date.formatted(format: timeFormat)
        
        let durationPicker = UIDatePicker()
        durationPicker.datePickerMode = .countDownTimer
        durationPicker.minuteInterval = 15
        durationPicker.countDownDuration = 15
        durationPicker.frame.size = CGSize(width: 0, height: 300)
        durationPicker.addTarget(self, action: #selector(changeDuration), for: .valueChanged)
        durationTextField.inputView = durationPicker
        
        timezonePicker.dataSource = self
        timezonePicker.delegate = self
        timezonePicker.frame.size = CGSize(width: 0, height: 300)
        timezoneTextField.inputView = timezonePicker
        
        reminderPicker.delegate = self
        reminderPicker.delegate = self
        reminderPicker.frame.size = CGSize(width: 0, height: 300)
        reminderTextField.inputView = reminderPicker
        
        timezoneTextField.text = timeZones[timezonePicker.selectedRow(inComponent: 0)]
        durationTextField.text = durationPicker.countDownDuration.formatted()
        reminderTextField.text = reminders[reminderPicker.selectedRow(inComponent: 0)]
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
        if profileCount == maxProfiles {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .blue
            label.textAlignment = .center
            label.textColor = .white
            label.text = "\(profileCount - maxProfiles + 1)+"
            label.widthAnchor.constraint(equalToConstant: 40).isActive = true
            label.heightAnchor.constraint(equalToConstant: 40).isActive = true
            label.clipsToBounds = true
            label.layer.cornerRadius = 20
            attendeesStackView.addArrangedSubview(label)
        } else if profileCount > maxProfiles {
            if let label = attendeesStackView.arrangedSubviews.last as? UILabel {
                label.text = "\(profileCount - maxProfiles + 1)+"
            }
        } else {
            let imageView = UIImageView(image: .randomProfileImage()?.resizedImage(to: 40))
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            attendeesStackView.addArrangedSubview(imageView)
        }
        profileCount += 1
        emailTextField.text = ""
    }
    
    private func updateSubmitButton() {
        saveButton.layer.opacity = checkRequiredFields() ? 1 : 0.5
    }
    
    @objc func changeDuration(_ sender: UIDatePicker) {
        if sender.countDownDuration > (60 * 60 * 8) {
            sender.countDownDuration = 60 * 60 * 8
        }
        durationTextField.text = sender.countDownDuration.formatted()
    }
    
    @objc func changeReminder(_ sender: UIDatePicker) {
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
        updateSubmitButton()
    }
}

// MARK: - TextField
extension ScheduleMetingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            if isValidEmail(textField.text) {
                addUser(email: textField.text)
            } else {
                showToast(message: "Invalid Email")
            }
        } else if textField == meetingTitleTextField {
            descriptionTextView.becomeFirstResponder()
        } else {
            hideKeyboard()
        }
        return true
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
        return pickerView == timezonePicker ? timeZones.count : reminders.count
    }
}

extension ScheduleMetingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == timezonePicker ? timeZones[row] : reminders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == timezonePicker {
            timezoneTextField.text = timeZones[row]
        } else {
            reminderTextField.text = reminders[row]
        }
    }
}
