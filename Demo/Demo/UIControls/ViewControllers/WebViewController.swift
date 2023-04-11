//
//  WebViewController.swift
//  Demo
//
//  Created by Krunal Patel on 11/04/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var progressLoading: UIProgressView!
    let blacklistedDomains: [String] = [".pk", ".au", ".gov.in", ".gov."]
    var timer: Timer?
    
    var search: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotification()
        setupUI()
    }
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        webView.load(url: search ?? "https://krunalpatel.me")
        print("url: \(search)")
        webView.navigationDelegate = self
        progressLoading.progressTintColor = .cyan.withAlphaComponent(0.3)
        progressLoading.layer.cornerRadius = 10
        searchBar.keyboardType = .webSearch
        
    }
    
    private func setupSearchBar() {
        searchBar.searchTextField.text = webView.title ?? webView.url?.absoluteString
        searchBar.searchTextField.leftView = UIImageView(image: UIImage(systemName: "lock.slash"))
        searchBar.searchTextField.tintColor = .gray
        
        if let secTrust = webView.serverTrust, SecTrustEvaluateWithError(secTrust, nil) {
            print("Secure")
            if let imageView = searchBar.searchTextField.leftView as? UIImageView {
                imageView.image = UIImage(systemName: "lock.shield")
            }
            searchBar.searchTextField.tintColor = .systemGreen
        }
    }
    
    private func progressUpdate(start: Bool) {
        progressLoading.isHidden = !start
        if start {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self else { return }
                
                print("loading: \(self.webView.estimatedProgress)")
                self.progressLoading.progress = Float(self.webView.estimatedProgress)
            }
        } else {
            timer?.invalidate()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.searchBar.frame.origin.y = (self.view.frame.height - self.searchBar.frame.height) - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.searchBar.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.size.height
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator.startAnimating()
        
        progressUpdate(start: true)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
        setupSearchBar()
        progressUpdate(start: false)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if blacklistedDomains.contains(where: host.hasSuffix) {
                print("\(host) is blocked")
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
}

extension WebViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = webView.url?.absoluteString
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        webView.load(url: searchBar.searchTextField.text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.searchTextField.text = webView.title
    }
}

extension WKWebView {
    func load(url: String?) {
        guard var url else { return }
        
        url = url.replacingOccurrences(of: " ", with: "+")
        
        if var url = URL(string: url) {
            if !UIApplication.shared.canOpenURL(url) {
                if let searchUrl = URL(string: "https://www.google.com/search?q=\(url)") {
                    url = searchUrl
                }
            }
            print("u: \(url)")
            self.load(URLRequest(url: url))
        }
    }
}
