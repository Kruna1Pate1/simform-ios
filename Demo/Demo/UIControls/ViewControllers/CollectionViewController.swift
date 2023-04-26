//
//  CollectionViewController.swift
//  Demo
//
//  Created by Krunal Patel on 05/04/23.
//

import UIKit

class CollectionViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Private Variables
    private var songs: [SongModel.SongGenre: [SongModel]] = Dictionary(grouping: SongModel.dummySongs(), by: { $0.genre })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        collectionView.dragInteractionEnabled = true
        setupRefresh()
        
        searchBar.barTintColor = .lightGray
        searchBar.searchTextField.leftView = UIImageView(image: UIImage(systemName: "line.3.horizontal.decrease.circle.fill"))
        searchBar.searchTextField.tintColor = .white
        
        searchBar.searchTextField.rightView = UIImageView(image: UIImage(systemName: "trash"))
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    private func setupRefresh() {
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "loading", attributes: [
            .foregroundColor: UIColor.green
        ])
        refreshController.tintColor = .systemGreen
        collectionView.refreshControl = refreshController
    }
    
    @objc private func handleRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.songs = Dictionary(grouping: SongModel.dummySongs(), by: { $0.genre })
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func dismissKeyboard() {
        print("dismiss")
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songDetail" {
            let destinationVC = segue.destination as? WebViewController
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                destinationVC?.search = songs[indexPath.section].value[indexPath.item].title
            }
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs[section].value.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? SongCell else {
            return UICollectionViewCell()
        }
        cell.song = songs[indexPath.section].value[indexPath.item]
        cell.onLike = { isLiked in
            self.songs[indexPath.section].value[indexPath.item].isLiked = isLiked
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? GenreHeaderView else {
            return UICollectionViewCell()
        }
        headerView.lblTitle.text = songs[indexPath.section].key.rawValue.capitalized
        return headerView
    }
}

// MARK: - Collection View

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selecting: \(indexPath)")
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = collectionView.bounds.width
        
        if songs[indexPath.section].value.count > 8 {
            width = (width / 3) - 10
        } else {
            width = (width / 2) - 10
        }
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetching \(indexPaths)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("canceling prefetch \(indexPaths)")
    }
}

// MARK: - Search Bar

extension CollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.isEmpty {
            songs = Dictionary(grouping: SongModel.dummySongs(), by: { $0.genre })
        } else {
            songs = Dictionary(grouping: SongModel.dummySongs().filter { $0.title.contains(searchText)}, by: { $0.genre })
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return songs.count != 0
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("search button")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end")
    }
}
