//
//  DownloadApi.swift
//  Demo
//
//  Created by Krunal Patel on 14/06/23.
//

import UIKit

class DownloadApi {
    
    init(delegate: URLSessionDownloadDelegate?) {
        self.delegate = delegate
    }
    
    private var resumeData: Data?
    
    private var downloadTask: URLSessionDownloadTask?
    
    var delegate: URLSessionDownloadDelegate?
    
    private lazy var urlSession: URLSession = {
        let configuaration = URLSessionConfiguration.background(withIdentifier: "com.krunal.demo")
        configuaration.waitsForConnectivity = true
        configuaration.timeoutIntervalForRequest = 30
        return URLSession(configuration: configuaration, delegate: delegate, delegateQueue: nil)
    }()
    
    
    func downloadFile(url: URL) {
        
        let request = URLRequest(url: url)
        
        let downloadTask = urlSession.downloadTask(with: request)
        
        downloadTask.resume()
        self.downloadTask = downloadTask
    }
    
    func pauseDownload() {
        downloadTask?.cancel(byProducingResumeData: {data in
            self.resumeData = data
        })
        downloadTask = nil
    }
    
    func resumeDownload() {
        if let resumeData = resumeData {
            downloadTask = urlSession.downloadTask(withResumeData: resumeData)
            downloadTask?.resume()
        }
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
        downloadTask = nil
    }
}
