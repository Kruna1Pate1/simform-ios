//
//  AFSDownloadViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 19/06/23.
//

import Foundation
import Alamofire

class AFSDownloadViewModel {
    
    let errorMessage = Dynamic<String>("")
    let downloadSuccess = Dynamic<String>("")
    let progressValue = Dynamic<Float>(0)
    
    func downloadFile(url: String) {
        guard let url = URL(string: url) else {
            errorMessage.value = "Invalid URL"
            return
        }
        
        var fileURL: URL?
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0]
            fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            return (fileURL!, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        APIManager.shared.callDownload(type: .downloadFile(url: url.absoluteString), destination: destination, progressHandler: { progress in
            self.progressValue.value = progress
        }) { (result: Result<Void, CustomError>) in
            switch result {
            case .success():
                guard let path = fileURL?.absoluteString else {
                        self.errorMessage.value = APIError.genericErrorMessage
                        return
                }
                self.downloadSuccess.value = path
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
}
