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
    @IBOutlet private weak var tfMmeetingTitle: MyTextField!
    @IBOutlet private weak var tvDescription: MyTextView!
    @IBOutlet private weak var tfDate: MyTextField!
    @IBOutlet private weak var tfTime: MyTextField!
    @IBOutlet private weak var tfTimezone: MyTextField!
    @IBOutlet private weak var tfDuration: MyTextField!
    @IBOutlet private weak var tfReminder: MyTextField!
    @IBOutlet private weak var switchRequiredPassword: UISwitch!
    @IBOutlet private weak var tfPassword: MyTextField!
    @IBOutlet private weak var tfEmail: MyTextField!
    @IBOutlet private weak var btnAdd: UIButton!
    @IBOutlet private weak var btnSave: UIButton!
    @IBOutlet private weak var meetingPaswordContainer: UIStackView!
    @IBOutlet private weak var svAttendees: UIStackView!
    
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
        tvDescription.inputAccessoryView = toolbar
        tfTimezone.inputAccessoryView = toolbar
        tfDuration.inputAccessoryView = toolbar
        tfReminder.inputAccessoryView = toolbar
        tfPassword.inputAccessoryView = toolbar
        
        btnSave.clipsToBounds = true
        btnSave.layer.cornerRadius = 10
        btnSave.layer.opacity = 0.5
    }
    
    private func setupTextFields() {
        let datePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, tfDate.bounds.height))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        self.tfDate.insertSubview(datePicker, at: 0)
        tfDate.text = datePicker.date.formatted(format: dateFormat)
        
        
        let timePicker = UIDatePicker(frame: CGRectMake(0, 0, 30, tfTime.bounds.height))
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        timePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        self.tfTime.insertSubview(timePicker, at: 0)
        tfTime.text = timePicker.date.formatted(format: timeFormat)
        
        let durationPicker = UIDatePicker()
        durationPicker.datePickerMode = .countDownTimer
        durationPicker.minuteInterval = 15
        durationPicker.countDownDuration = 15
        durationPicker.frame.size = CGSize(width: 0, height: 300)
        durationPicker.addTarget(self, action: #selector(changeDuration), for: .valueChanged)
        tfDuration.inputView = durationPicker
        
        timezonePicker.dataSource = self
        timezonePicker.delegate = self
        timezonePicker.frame.size = CGSize(width: 0, height: 300)
        tfTimezone.inputView = timezonePicker
        
        reminderPicker.delegate = self
        reminderPicker.delegate = self
        reminderPicker.frame.size = CGSize(width: 0, height: 300)
        tfReminder.inputView = reminderPicker
        
        tfTimezone.text = timeZones[timezonePicker.selectedRow(inComponent: 0)]
        tfDuration.text = durationPicker.countDownDuration.formatted()
        tfReminder.text = reminders[reminderPicker.selectedRow(inComponent: 0)]
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func checkRequiredFields() -> Bool {
        if tfMmeetingTitle.text?.isEmpty == true {
            print("\(tfMmeetingTitle) is required")
            return false
        }
        else if tfDate.text?.isEmpty == true {
            print("\(tfDate) is required")
            return false
        }
        else if tfTime.text?.isEmpty == true {
            print("\(tfTime) is required")
            return false
        }
        else if tfTimezone.text?.isEmpty == true {
            print("\(tfTimezone) is required")
            return false
        }
        else if tfDuration.text?.isEmpty == true {
            print("\(tfDuration) is required")
            return false
        } else if switchRequiredPassword.isOn && tfPassword.text?.isEmpty == true {
            print("\(tfPassword) is required")
            return false
        } else if svAttendees.arrangedSubviews.count < 1 {
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
            svAttendees.addArrangedSubview(label)
        } else if profileCount > maxProfiles {
            if let label = svAttendees.arrangedSubviews.last as? UILabel {
                label.text = "\(profileCount - maxProfiles + 1)+"
            }
        } else {
            let imageView = UIImageView(image: .randomProfileImage()?.resizedImage(to: 40))
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            svAttendees.addArrangedSubview(imageView)
        }
        profileCount += 1
        tfEmail.text = ""
    }
    
    private func updateSubmitButton() {
        btnSave.layer.opacity = checkRequiredFields() ? 1 : 0.5
    }
    
    @objc func changeDuration(_ sender: UIDatePicker) {
        if sender.countDownDuration > (60 * 60 * 8) {
            sender.countDownDuration = 60 * 60 * 8
        }
        tfDuration.text = sender.countDownDuration.formatted()
    }
    
    @objc func changeReminder(_ sender: UIDatePicker) {
        if sender.countDownDuration > (60 * 60) {
            sender.countDownDuration = 60 * 60
        }
        tfReminder.text = "\(sender.countDownDuration.formatted(units: [.minute])) before"
    }
    
    @objc func changeDate(_ sender: UIDatePicker) {
        tfDate.text = sender.date.formatted(format: dateFormat)
    }
    
    @objc func changeTime(_ sender: UIDatePicker) {
        if sender.date < Date() {
            sender.date = Date()
        }
        tfTime.text = sender.date.formatted(format: timeFormat)
    }
    
    @IBAction func addUserClick(_ sender: UIButton) {
        if isValidEmail(tfEmail.text) {
            addUser(email: tfEmail.text)
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
        if textField == tfEmail {
            if isValidEmail(textField.text) {
                addUser(email: textField.text)
            } else {
                showToast(message: "Invalid Email")
            }
        } else if textField == tfMmeetingTitle {
            tvDescription.becomeFirstResponder()
        } else {
            hideKeyboard()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfEmail {
            print(string)
            if string == "," || string == " " {
                if isValidEmail(tfEmail.text) {
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
            tfTimezone.text = timeZones[row]
        } else {
            tfReminder.text = reminders[row]
        }
    }
}
