//
//  ProductViewController.swift
//  Demo
//
//  Created by Krunal Patel on 17/04/23.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productContainer: UIStackView!
    @IBOutlet weak var sizeContainer: UIStackView!
    
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var colorContainer: UIStackView!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UIButton!
    @IBOutlet weak var assuredImage: UIImageView!
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var offersTabelView: UITableView!
    
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    var product: ProductModel = ProductModel.dummyProducts()[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerCells()
    }
    
    private func setupUI() {
        setupContainers()
        setupOverlayView()

        ratingLabel.clipsToBounds = true
        ratingLabel.layer.cornerRadius = ratingLabel.bounds.height / 2
        
        colorPicker.isHidden = true
        
        setupData()
    }
    
    private func setupContainers() {
        productContainer.clipsToBounds = true
        productContainer.layer.cornerRadius = 10
        productContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        sizeContainer.clipsToBounds = true
        sizeContainer.layer.cornerRadius = 10
        sizeContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(toggleColorPickerVisibility))
        colorContainer.addGestureRecognizer(tapGesture)
    }
    
    @objc func toggleColorPickerVisibility(_ sender: UITapGestureRecognizer) {
        colorPicker.isHidden.toggle()
        print(colorPicker.isHidden)
    }
    
    private func setupOverlayView() {
        likeView.clipsToBounds = true
        likeView.layer.cornerRadius = likeView.bounds.height / 2
        likeView.layer.borderWidth = 0.5
        likeView.layer.borderColor = UIColor.gray.cgColor
        likeView.layer.shadowColor = UIColor.gray.cgColor
        likeView.layer.shadowOpacity = 0.5
        
        colorContainer.clipsToBounds = true
        colorContainer.layer.cornerRadius = colorContainer.bounds.height / 2
        colorContainer.layer.borderWidth = 0.5
        colorContainer.layer.borderColor = UIColor.gray.cgColor
        colorContainer.layer.shadowColor = UIColor.darkGray.cgColor
        colorContainer.layer.shadowOpacity = 0.5
    }
    
    private func setupData() {
        finalPriceLabel.text = "₹\(product.price.finalPrice)"
        let strikePrice = NSAttributedString(string: "\(product.price.originalPrice)", attributes: [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ])
        oldPriceLabel.attributedText = strikePrice
        discountLabel.text = "\(product.price.discount)% off"
        ratingLabel.text = "\(product.rating) ★"
        reviewsLabel.titleLabel?.text = "\(product.reviews?.count ?? 0) reviews >"
        assuredImage.isHidden = !product.isAssured
        imagePageControl.numberOfPages = product.images?.count ?? 0
    }
    
    private func registerCells() {
        offersTabelView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
    }
    
    @IBAction func changeImage(_ sender: UIPageControl) {
        if sender.currentPage != imagesCollectionView.indexPathsForVisibleItems.first?.item {
            imagesCollectionView.selectItem(at: IndexPath(item: sender.currentPage, section: 0), animated: true, scrollPosition: .top)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sizeGuide" {
            let destinationVC = segue.destination as? WebViewController
            destinationVC?.search = "https://www.asics.com/in/en-in/clothing-size-guide"
        }
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.offers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == offersTabelView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as? OfferCell {
                cell.offerDescriptionTabel.text = product.offers?[indexPath.item]
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ProductViewController: UITableViewDelegate {
    
}

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == imagesCollectionView ? product.images?.count : product.sizes?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
                cell.image.image = product.images?[indexPath.item]
                return cell
            }
        }
        
        if collectionView == sizeCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCell", for: indexPath) as? SizeCell {
                product.sizes?[indexPath.item].onSelect = { isSelected in
                    cell.selection = isSelected
                }
                cell.sizeButton.setTitle(product.sizes?[indexPath.item].name, for: .normal)
                cell.sizeButton.setTitle(product.sizes?[indexPath.item].name, for: .selected)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imagePageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imagePageControl.currentPage = collectionView.indexPathsForVisibleItems[0].item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sizeCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
                cell.selection = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == sizeCollectionView {
            print(indexPath)
            if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
                product.sizes?[indexPath.item].isSelected = false
            }
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.bounds)
        return collectionView == imagesCollectionView ? CGSizeMake(collectionView.bounds.width, collectionView.bounds.height) : CGSizeMake(80, 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == imagesCollectionView ? 0 : 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        product.colors?.count ?? 0
    }
}

extension ProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        product.colors?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected color: \(product.colors?[row])")
    }
}
