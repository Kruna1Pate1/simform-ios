//
//  AFSLoginViewController.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit
import PhotosUI

class AFSRegisterViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var txtName: MyTextField!
    @IBOutlet private weak var txtEmail: MyTextField!
    @IBOutlet private weak var txtNumber: MyTextField!
    @IBOutlet private weak var imgProfile: UIImageView!
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var txtContry: MyTextField!
    
    private let viewModel = AFSRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindRegisterUI()
        bindUploadImage()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.errorMessage.bind { [weak self] message in
            self?.showAlert(title: "Registration failed", message: message)
        }
    }
    
    private func bindRegisterUI() {
        viewModel.registerSuccess.bind {  [weak self] userId in
            guard let self = self else { return }
            
            self.showAlert(title: "Login successful", message: "Id: \(userId)") {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AFSUpdateVC") as? AFSUpdateViewController {
                    vc.userId = userId
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    private func bindUploadImage() {
        viewModel.progressValue.bind {  [weak self] progress in
            guard let self = self else { return }
            
            self.progressBar.isHidden = (progress == 0) || (progress == 1)
            self.progressBar.progress = progress
        }
    }
    
    // MARK: - IBActions
    @IBAction func onRegisterClicked(_ sender: UIButton) {
        viewModel.validateData(name: txtName.text ?? "", email: txtEmail.text ?? "", number: txtNumber.text ?? "", country: txtContry.text ?? "", image: imgProfile.image)
    }
    
    @IBAction func setImage(_ sender: UIButton) {
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
            
            present(imagePicker, animated: true)
        }
    }
}

// MARK: - Image Picker
extension AFSRegisterViewController: UIImagePickerControllerDelegate {
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
extension AFSRegisterViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
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
