//
//  LoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import Foundation
import Alamofire

class ProductViewModel {
    
    private let categoryUrl = AFDemoConstants.baseUrl + "/products/categories"
    private let filterUrl = AFDemoConstants.baseUrl + "/products/category"
    private let productUrl = AFDemoConstants.baseUrl + "/products"
    
    weak var delegate: AFProductViewControllerDelegate?
    
    private (set) var filters: [String] = [] {
        didSet {
            delegate?.product(filtersDidChange: filters)
        }
    }
    
    private var originalProducts: [Product] = [] {
        didSet {
            products = originalProducts
        }
    }
    
    private (set) var products: [Product] = [] {
        didSet {
            delegate?.product(productsDidChange: products)
        }
    }
    
    private var timer: Timer? = nil
    private let delay: TimeInterval = 2 // Second
    
    init() {
        getFilters()
        getProducts()
    }
    
    func getFilters() {
        AFApiManager.shared.call(url: categoryUrl) { [weak self] (result: Result<[String], ApiError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let categories):
                self.filters = categories
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getProducts() {
        AFApiManager.shared.call(url: productUrl) { [weak self] (result: Result<[Product], ApiError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.originalProducts = products
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func filterProducts(filter: String) {
        let filterUrl = "\(filterUrl)/\(filter)"
        
        guard let encodedURL = filterUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            //Invalid URL
            return
        }
        
        AFApiManager.shared.call(url: encodedURL) { [weak self] (result: Result<[Product], ApiError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.originalProducts = products
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func searchFilter(keyword: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            if keyword.isEmpty {
                self.products = self.originalProducts
            } else {
                self.products = self.originalProducts.filter { $0.title?.contains(keyword) == true }
            }
        }
    }
}
