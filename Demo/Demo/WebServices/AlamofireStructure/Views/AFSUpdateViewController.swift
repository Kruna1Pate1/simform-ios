//
//  AFSLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit
import PhotosUI

class AFSUpdateViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtName: MyTextField!
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var txtNumber: MyTextField!
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var txtContry: MyTextField!
    
    // MARK: - Vars & Lets
    private let viewModel = AFSUpdateViewModel()
    var userId: String = "55"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUserDetail()
        bindViewModel()
        bindUpdateUI()
        bindUploadImage()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        viewModel.getUser(userId: userId)
    }
    
    private func bindUserDetail() {
        viewModel.userDetails.bind { user in
            guard let user = user else { return }
            
            self.txtName.text = user.name
            self.txtEmail.text = user.email
            self.txtNumber.text = user.number
            self.txtContry.text = user.country
        }
        viewModel.profileImage.bind { image in
            self.imgProfile.image = image
        }
    }
    
    private func bindViewModel() {
        viewModel.errorMessage.bind { message in
            self.showAlert(title: "Details update failed", message: message)
        }
    }
    
    private func bindUpdateUI() {
        viewModel.registerSuccess.bind { userId in
            self.showAlert(title: "Details updated successful", message: "Id: \(userId)") {
            }
        }
    }
    
    private func bindUploadImage() {
        viewModel.progressValue.bind { progress in
            self.progressBar.isHidden = (progress == 0) || (progress == 1)
            self.progressBar.progress = progress
        }
    }
    
    @IBAction func onUpdateClicked(_ sender: UIButton) {
        var image: UIImage? = nil
        if imgProfile.image != viewModel.profileImage.value {
            image = imgProfile.image
        }
        viewModel.validateData(userId: userId, name: txtName.text ?? "", email: txtEmail.text ?? "", number: txtNumber.text ?? "", country: txtContry.text ?? "", image: image)
    }
    
    @IBAction func editImage(_ sender: UIButton) {
        if #available(iOS 14, *) {
            var configuaration = PHPickerConfiguration()
            configuaration.filter = .images
            configuaration.selectionLimit = 1
            configuaration.selection = .ordered
            
            let picker = PHPickerViewController(configuration: configuaration)
            picker.delegate = self
            present(picker, animated: true)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true)
        }
    }
}

// MARK: - Image Picker
extension AFSUpdateViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        
        guard let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage else { return }
        imgProfile.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

// MARK: - PHPicker
extension AFSUpdateViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvider = results.randomElement()?.itemProvider
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let self = self, let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.imgProfile.image = image
                    }
                }
            }
        }
    }
}
