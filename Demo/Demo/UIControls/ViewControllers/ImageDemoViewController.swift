//
//  ImageDemoViewController.swift
//  Demo
//
//  Created by Krunal Patel on 10/04/23.
//

import UIKit
import PhotosUI

class ImageDemoViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var conetentModeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conetentModeTable.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: "LanguageCell")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        
    }

    @IBAction func pickImage(_ sender: UIButton) {
        
        if #available(iOS 14, *) {
            var configuaration = PHPickerConfiguration()
            configuaration.filter = .images
            configuaration.selectionLimit = 2
            configuaration.selection = .ordered
            
            let picker = PHPickerViewController(configuration: configuaration)
            picker.delegate = self
            present(picker, animated: true)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.video"]
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true)
        }
    }
}

extension ImageDemoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picked \(info)")
        dismiss(animated: true)
        
        guard let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage else { return }
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled \(picker.title)")
        dismiss(animated: true)
    }
}

extension ImageDemoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("PPPicker: \(results)")
        dismiss(animated: true)
        
        let itemProvider = results.randomElement()?.itemProvider
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                DispatchQueue.main.async {                    
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}

extension ImageDemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as? LanguageCell, let mode = UIView.ContentMode(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.lblTitle.text = mode.name
        cell.btnSelection.isSelected = imageView.contentMode == mode
        
        return cell
    }
}

extension ImageDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        imageView.contentMode = .init(rawValue: indexPath.row) ?? .scaleAspectFit
        
        if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
            cell.btnSelection.isSelected = true
        }
        print(imageView.contentMode)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LanguageCell {
            cell.btnSelection.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension UIView.ContentMode {
    var name: String {
        switch self {
        case .scaleToFill:
            return "scaleToFill"
        case .scaleAspectFit:
            return "scaleAspectFit"
        case .scaleAspectFill:
            return "scaleAspectFill"
        case .redraw:
            return "redraw"
        case .center:
            return "center"
        case .top:
            return "top"
        case .bottom:
            return "bottom"
        case .left:
            return "left"
        case .right:
            return "right"
        case .topLeft:
            return "topLeft"
        case .topRight:
            return "topRight"
        case .bottomLeft:
            return "bottomLeft"
        case .bottomRight:
            return "bottomRight"
        @unknown default:
            fatalError()
        }
    }
}