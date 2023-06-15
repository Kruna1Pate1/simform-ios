//
//  LoginViewModel.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import Foundation

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
    
    private (set) var products: [Product] = [] {
        didSet {
            delegate?.product(productsDidChange: products)
        }
    }
    
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
                self.products = products
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func filterProducts(filter: String) {
        let filterUrl = "\(filterUrl)/\(filter)"
        AFApiManager.shared.call(url: filterUrl) { [weak self] (result: Result<[Product], ApiError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.products = products
                break
            case .failure(let error):
                break
            }
        }
    }
}
