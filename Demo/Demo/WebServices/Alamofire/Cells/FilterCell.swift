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
        setupView()
    }

    // MARK: - Methods
    private func setupView() {
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 0.5
        layer.borderColor = isSelected ? UIColor(named: "Secondary")?.cgColor : UIColor(named: "LightGray")?.cgColor
        
        let transparentView = UIView(frame: bounds)
        transparentView.backgroundColor = UIColor.clear
        backgroundView = transparentView


        let blueView = UIView(frame: bounds)
        blueView.backgroundColor = UIColor(named: "Secondary")
        selectedBackgroundView = blueView
    }
    
    func configCell(filter: String) {
        txtFilterName.text = filter
    }
}
