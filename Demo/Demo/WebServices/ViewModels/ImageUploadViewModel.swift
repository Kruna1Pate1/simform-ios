//
//  UploadImageViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 03/07/23.
//

import UIKit

class ImageUploadViewModel {
    
    var api = ImageUploadApi()
    weak var delegate: ImageUploadViewControllerDelegate? = nil
    
    func callToUploadImage(image: UIImage, taskDelegate: URLSessionTaskDelegate) {
        
        let task = api.uploadImage(image: image) {
            [weak self] (result: Result<ImageUploadResponse, ApiError>) in
            guard let self = self else { return }
            
            self.delegate?.imageUploadViewController(isUploading: true)
            switch result {
            case .success(let response):
                if let url = response.data?.image?.url {
                    self.delegate?.imageUploadViewController(urlDidChange: url)
                    self.delegate?.imageUploadViewController(isUploading: false)
                }
            case .failure(let error):
                self.delegate?.imageUploadViewController(urlDidChange: error.localizedDescription)
                self.delegate?.imageUploadViewController(isUploading: false)
            }
        }
        
        task?.delegate = taskDelegate
        task?.resume()
    }
}
