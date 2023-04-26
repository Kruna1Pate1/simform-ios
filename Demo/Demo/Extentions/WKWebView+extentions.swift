//
//  WKWebView+extentions.swift
//  Demo
//
//  Created by Krunal Patel on 21/04/23.
//

import WebKit

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
            load(URLRequest(url: url))
        }
    }
}
