//
//  FilterCell.swift
//  Demo
//
//  Created by Krunal Patel on 15/06/23.
//

import UIKit

class FilterCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var txtFilterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = bounds.height / 2
        
        let transparentView = UIView(frame: bounds)
        transparentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        backgroundView = transparentView


        let blueView = UIView(frame: bounds)
        blueView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 0.5270390795)
        selectedBackgroundView = blueView
    }

    // MARK: - Methods
    func configCell(filter: String) {
        txtFilterName.text = filter
    }
}
