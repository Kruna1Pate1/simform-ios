//
//  ProductModel.swift
//  Demo
//
//  Created by Krunal Patel on 17/04/23.
//

import UIKit

struct ProductModel {
    var images: [UIImage]?
    var colors: [String]?
    var brandName: String
    var productName: String
    var price: PriceModel
    var rating: Float = 0
    var reviews: [String]?
    var isAssured: Bool = false
    var offers: [String]?
    var sizes: [SizeModel]?
    
    struct PriceModel {
        var finalPrice: Int {
            originalPrice - Int(Float(originalPrice) * (discount / 100.0))
        }
        var originalPrice: Int
        var discount: Float
    }
    
    struct SizeModel {
        var name: String
        var isSelected: Bool = false {
            didSet {
                onSelect?(isSelected)
            }
        }
        var isDisabled: Bool = false
        var onSelect: ((_ isSelected: Bool) -> ())?
    }
    
    static func dummyProducts() -> [ProductModel] {
        return [
            ProductModel(images: Array(repeating: UIImage(named: "kurta_0")!, count: 5), colors: ["Red", "Yellow", "Pink"], brandName: "Aurelia", productName: "Printed Women's Straight'", price: PriceModel(originalPrice: 1599, discount: 57), rating: 4.3, reviews: Array(repeating: "", count: 9982), isAssured: true, offers: [
                "Flat 100 off* with digibank by DBS",
                "Extra 5% off Axis Bank Buzz credit cards"
            ], sizes: [
                SizeModel(name: "S"),
                SizeModel(name: "M"),
                SizeModel(name: "L", isSelected: true),
                SizeModel(name: "XL"),
                SizeModel(name: "XXL", isDisabled: true)
            ])
        ]
    }
}
