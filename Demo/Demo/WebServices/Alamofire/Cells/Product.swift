//
//  FilterCell.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import UIKit
import Alamofire

class ProductCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imgProduct: UIImageView!
    @IBOutlet private weak var txtTitle: UILabel!
    @IBOutlet private weak var txtPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCell(product: Product) {
        if let imgUrl = product.image {
            AF.request(imgUrl).responseData { data in
                if let imgData = data.data {
                    self.imgProduct.image = UIImage(data: imgData)
                }
            }
        }
        
        txtTitle.text = product.title
        txtPrice.text = "$\(product.price ?? -1)"
    }
}
