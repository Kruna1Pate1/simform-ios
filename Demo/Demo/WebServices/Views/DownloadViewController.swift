//
//  DownloadViewController.swift
//  Demo
//
//  Created by Krunal Patel on 14/06/23.
//

import UIKit

class DownloadViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var txtUrl: UITextField!
    @IBOutlet private weak var txtLastDownload: UILabel!
    @IBOutlet private weak var txtError: UILabel!
    @IBOutlet private weak var progressBarFile: UIProgressView!
    
    // MARK: - Variables
    private var downloadApi: DownloadApi!
    private var isDownloading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadApi = DownloadApi(delegate: self)
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        let lastDownload = UserDefaults.standard.url(forKey: "lastDownload")
        txtLastDownload.text = lastDownload?.absoluteString
    }
    
    // MARK: - IBActions
    @IBAction func startDownload(_ sender: UIButton) {
        guard let text = txtUrl.text, let url = URL(string: text) else {
            txtError.text = "Invalid url"
            return
        }
        
        downloadApi.downloadFile(url: url)
    }
    
    @IBAction func toggleDownload(_ sender: UIButton) {
        if (sender.isSelected) {
            downloadApi.pauseDownload()
        } else {
            downloadApi.resumeDownload()
        }
    }
    
    @IBAction func cancelDownload(_ sender: UIButton) {
        downloadApi.cancelDownload()
    }
}

extension DownloadViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)
        
        UserDefaults.standard.set(destinationURL, forKey: "lastDownload")
        
        do {
            try? FileManager.default.removeItem(at: destinationURL)
            try FileManager.default.copyItem(at: location, to: destinationURL)
        } catch {
            print("Error saving file:", error)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Progress: \(totalBytesWritten) \(totalBytesExpectedToWrite)")
        DispatchQueue.main.sync {
            self.progressBarFile?.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
      DispatchQueue.main.async {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
          let completionHandler = appDelegate.backgroundSessionCompletionHandler {
          appDelegate.backgroundSessionCompletionHandler = nil
          
          completionHandler()
        }
      }
    }
    
}
