//
//  AFSLoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import UIKit

class AFSRegisterViewModel {
    
    let errorMessage = Dynamic<String>("")
    let registerSuccess = Dynamic<String>("")
    let progressValue = Dynamic<Float>(0)

    func validateData(name: String, email: String, number: String, country: String, image: UIImage? = nil) {
        
        guard !name.isEmpty else {
            errorMessage.value = "Name can't be empty"
            return
        }
        
        guard !email.isEmpty else {
            errorMessage.value = "Email can't be empty"
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage.value = "Invalid email"
            return
        }
        
        guard let image = image else {
            errorMessage.value = "Please upload image"
            return
        }
        
        callUploadImageApi(image: image) { imageUrl in
            self.callRegisterApi(avatar: imageUrl, name: name, email: email, number: number, country: country)
        }

    }
    
    func callRegisterApi(avatar: String, name: String, email: String, number: String, country: String) {
        let params = ["avatar": avatar,
                      "name": name,
                      "email": email,
                      "number": number,
                      "country": country]
        APIManager.shared.call(type: .register, params: params) { (result: Result<UserDetailResponse, CustomError>) in
            switch result {
            case .success(let response):
                guard let userId = response.id else {
                    self.errorMessage.value = APIError.genericErrorMessage
                    return
                }
                self.registerSuccess.value = userId
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func callUploadImageApi(image: UIImage, compeletion: @escaping (_ imageUrl: String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        APIManager.shared.callUpload(type: .uploadImage, data: imageData, progressHandler: { progress in
            self.progressValue.value = progress
        }) { (result: Result<ImageUploadResponse, CustomError>) in
            switch result {
            case .success(let response):
                guard let imageUrl = response.data?.image?.url else {
                    self.errorMessage.value = APIError.genericErrorMessage
                    return
                }
                compeletion(imageUrl)
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
}
