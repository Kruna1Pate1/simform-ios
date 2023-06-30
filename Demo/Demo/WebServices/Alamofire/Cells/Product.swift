//
//  FilterCell.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import UIKit
import Alamofire
import Kingfisher

class ProductCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imgProduct: UIImageView!
    @IBOutlet private weak var txtTitle: UILabel!
    @IBOutlet private weak var txtPrice: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        container.layer.cornerRadius = 5
        container.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        container.layer.borderWidth = 0.5
    }

    func configCell(product: Product) {
        if let image = product.image {
            imgProduct.kf.setImage(with: URL(string: image))
        }
        
        // Mannual loading of image
//        if let imgUrl = product.image {
//            AF.request(imgUrl).responseData { data in
//                if let imgData = data.data {
//                    self.imgProduct.image = UIImage(data: imgData)
//                }
//            }
//        }
        
        txtTitle.text = product.title
        txtPrice.text = "$\(product.price ?? -1)"
    }
}
