//
//  ImageUploadApi.swift
//  Demo
//
//  Created by Krunal Patel on 13/06/23.
//

import UIKit

class ImageUploadApi {
    
    let apiKey = "c7ff9cb8aa396cf2bd53bb631e48db32"
    let url = "https://api.imgbb.com/1/upload"
    
    func uploadImage(image: UIImage, completion: @escaping (Result<ImageUploadResponse, ApiError>) -> ()) -> URLSessionUploadTask? {
        guard var url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return nil
        }
        
        url.append(queryItems: [URLQueryItem(name: "key", value: apiKey)])
        var request = URLRequest(url: url)
        
        request.addValue("multipart/form-data; boundary=\(MultiPartFormData.boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(.unknownError("Couldn't parse image")))
            return nil
        }
        
        // TODO: Base64
        // To upload in form of Base64
        // 
        
        let body = MultiPartFormData.getBindaryFormData(params: ["image" : (imageData, filename: "random_image.jpeg")])
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: body) { (data, urlResponse, error) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data {
                    let response = try decoder.decode(ImageUploadResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                }
            } catch let error {
                completion(.failure(.unknownError(error.localizedDescription)))
            }
        }
        
        return uploadTask
    }
}
