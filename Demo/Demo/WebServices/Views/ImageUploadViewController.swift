//
//  ImageUploadViewController.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import UIKit
import PhotosUI

// MARK: - Image Upload View Controller Delegate
protocol ImageUploadViewControllerDelegate: AnyObject {
    
    func imageUploadViewController(imageDidChange image: UIImage)
    
    func imageUploadViewController(urlDidChange url: String)
    
    func imageUploadViewController(isUploading uploading: Bool)
}

class ImageUploadViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgImage: UIImageView!
    @IBOutlet private weak var progressBarImage: UIProgressView!
    @IBOutlet private weak var txtUrl: UILabel!
    
    // MARK: - Variables
    private var viewModel: ImageUploadViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        viewModel = ImageUploadViewModel()
        viewModel.delegate = self
        txtUrl.isHidden = false
        progressBarImage.isHidden = true
    }
    
    func uploadImage(image: UIImage) {
        viewModel.callToUploadImage(image: image, taskDelegate: self)
    }
    
    // MARK: - IBActions
    @IBAction func pickImage(_ sender: UIButton) {
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

// MARK: - Image Picker Controller Delegate
extension ImageUploadViewController: ImageUploadViewControllerDelegate {
    func imageUploadViewController(imageDidChange image: UIImage) {
        imgImage.image = image
    }
    
    func imageUploadViewController(urlDidChange url: String) {
        txtUrl.text = url
    }
    
    func imageUploadViewController(isUploading uploading: Bool) {
        txtUrl.isHidden = uploading
        progressBarImage.isHidden = !uploading
    }
}

// MARK: - Image Picker
extension ImageUploadViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        
        guard let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage else { return }
        imgImage.image = image
        uploadImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

// MARK: - PHPicker
extension ImageUploadViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("PHPicker: \(results)")
        dismiss(animated: true)
        
        let itemProvider = results.randomElement()?.itemProvider
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let self = self, let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.imgImage.image = image
                        self.uploadImage(image: image)
                    }
                }
            }
        }
    }
}

// MARK: - URL Session Task
extension ImageUploadViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("total: \(totalBytesExpectedToSend), send: \(totalBytesSent)")
        DispatchQueue.main.async { [weak self] in
            self?.progressBarImage.progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        }
    }
}
