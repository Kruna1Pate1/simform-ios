//
//  WebViewController.swift
//  Demo
//
//  Created by Krunal Patel on 11/04/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var progressLoading: UIProgressView!
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private var webToolbarItems: [UIBarButtonItem]!
    
    // MARK: - Private Constants
    
    private let blacklistedDomains: [String] = [".pk", ".au", ".gov.in", ".gov."]
    
    // MARK: - Private Variables
    
    private var timer: Timer?
    
    // MARK: - Public Variables
    
    public var search: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotification()
        setupUI()
    }
    
    // MARK: - Private Methods
    
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
        
        toolbar.tintColor = .orange
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
                
                self.progressLoading.progress = Float(self.webView.estimatedProgress)
            }
        } else {
            timer?.invalidate()
        }
    }
    
    private func updateToolbar() {
        webToolbarItems[0].isEnabled = webView.canGoBack
        webToolbarItems[1].isEnabled = webView.canGoForward

        webToolbarItems[2].image = UIImage(systemName: webView.isLoading ? "xmark" : "arrow.clockwise")
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        if webView.isLoading {
            webView.stopLoading()
        } else {
            webView.reload()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            searchBar.frame.origin.y = (self.view.frame.height - self.searchBar.frame.height) - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        searchBar.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.size.height
    }
}

// MARK: - WebView

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator.startAnimating()
        
        progressUpdate(start: true)
        updateToolbar()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.stopAnimating()
        setupSearchBar()
        progressUpdate(start: false)
        updateToolbar()
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

// MARK: - Search Bar

extension WebViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = webView.url?.absoluteString
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        webView.load(url: searchBar.searchTextField.text)
    }
}
