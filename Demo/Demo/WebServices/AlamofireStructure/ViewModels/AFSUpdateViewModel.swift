//
//  AFSLoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 16/06/23.
//

import Foundation
import UIKit

class AFSUpdateViewModel {
    
    let errorMessage = Dynamic<String>("")
    let registerSuccess = Dynamic<String>("")
    let userDetails = Dynamic<UserDetailResponse?>(nil)
    let progressValue = Dynamic<Float>(0)
    let profileImage = Dynamic<UIImage?>(nil)
    
    func validateData(userId: String, name: String, email: String, number: String, country: String, image: UIImage? = nil) {
        
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
        
        if let image = image {
            callUploadImageApi(image: image) { [weak self] imageUrl in
                self?.callUpdateApi(userId: userId, avatar: imageUrl, name: name, email: email, number: number, country: country)
            }
        } else {
            callUpdateApi(userId: userId, name: name, email: email, number: number, country: country)
        }
    }
    
    func getUser(userId: String) {
        APIManager.shared.call(type: .getUser(userId: userId)) { [weak self] (result: Result<UserDetailResponse, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.userDetails.value = response
                if let imageUrl = response.avatar {
                    self.callLoadImageApi(imageUrl: imageUrl)
                }
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func callUpdateApi(userId: String, avatar: String? = nil, name: String, email: String, number: String, country: String) {
        var params = ["name": name,
                      "email": email,
                      "number": number,
                      "country": country]
        if let avatar = avatar {
            params["avatar"] = avatar
        }
        
        APIManager.shared.call(type: .update(userId: userId), params: params) { [weak self] (result: Result<UserDetailResponse, CustomError>) in
            guard let self = self else { return }
            
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
        
        APIManager.shared.callUpload(type: .uploadImage, data: imageData, progressHandler: { [weak self] progress in
            self?.progressValue.value = progress
        }) { [weak self] (result: Result<ImageUploadResponse, CustomError>) in
            guard let self = self else { return }
            
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
    
    func callLoadImageApi(imageUrl: String) {
        APIManager.shared.callLoadImage(type: .loadImage(url: imageUrl)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.profileImage.value = response
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
}
