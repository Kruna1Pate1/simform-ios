//
//  ProductViewController.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import UIKit

protocol AFProductViewControllerDelegate: AnyObject {
    func product(filtersDidChange filters: [String])
    func product(productsDidChange products: [Product])
}

class AFProductViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionViewFilter: UICollectionView!
    @IBOutlet private weak var collectionViewProduct: UICollectionView!
    
    // MARK: - Variables
    private var viewModel: ProductViewModel!
    
    override func viewDidLoad() {
        viewModel = ProductViewModel()
        viewModel.delegate = self
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        collectionViewFilter.dataSource = self
        collectionViewFilter.delegate = self
        collectionViewProduct.dataSource = self
        collectionViewProduct.delegate = self
    }
}

// MARK: - Product View Controller Delegate
extension AFProductViewController: AFProductViewControllerDelegate {
    func product(productsDidChange products: [Product]) {
        collectionViewProduct.reloadData()
    }
    
    func product(filtersDidChange filters: [String]) {
        collectionViewFilter.reloadData()
    }
}

// MARK: - Collection View
extension AFProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == collectionViewFilter ? viewModel.filters.count : viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewFilter {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell {
                
                cell.configCell(filter: viewModel.filters[indexPath.item])
                return cell
            }
        }
        else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
                
                cell.configCell(product: viewModel.products[indexPath.item])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension AFProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewFilter {
            let filter = viewModel.filters[indexPath.item]
            viewModel.filterProducts(filter: filter)
        }
    }
}

extension AFProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 40, height: collectionView.bounds.height / 2 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
