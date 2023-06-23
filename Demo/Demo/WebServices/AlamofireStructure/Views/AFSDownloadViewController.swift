//
//  AFSDownloadViewController.swift
//  Demo
//
//  Created by Krunal Patel on 19/06/23.
//

import UIKit

class AFSDownloadViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var txtUrl: UITextField!
    
    // MARK: - Vars & Lets
    @IBOutlet weak var txtDownloadPath: UILabel!
    private let viewModel = AFSDownloadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindDownloadUI()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        viewModel.errorMessage.bind { [weak self] message in
            self?.showAlert(title: "Download failed", message: message)
        }
    }
    
    private func bindDownloadUI() {
        viewModel.progressValue.bind { [weak self] progress in
            self?.progressBar.isHidden = (progress == 0) || (progress == 1)
            self?.progressBar.progress = progress
        }
        
        viewModel.downloadSuccess.bind { [weak self] path in
            self?.txtDownloadPath.text = path
        }
    }
   
    // MARK: - IBActions
    @IBAction func startDownload(_ sender: UIButton) {
        guard let url = txtUrl.text else {
            viewModel.errorMessage.value = "Empty URL"
            return
        }
        viewModel.downloadFile(url: url)
    }
}
