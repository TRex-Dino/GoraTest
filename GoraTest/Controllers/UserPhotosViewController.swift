//
//  UserPhotosViewController.swift
//  GoraTest
//
//  Created by Dmitry on 10.09.2021.
//

import UIKit

class UserPhotosViewController: UICollectionViewController {
    
    var userId: Int!
    private var photos = [Photo]()
    private let cell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserPhotos(photoId: userId)
    }
    
    func fetchUserPhotos(photoId: Int) {
        
        NetworkService.shared.fetchUserPhotos(photoId: photoId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                
                self.photos = photos
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(_):
                print("")
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! CustomCell
        
        let imageURL = photos[indexPath.item].url
        
        cell.activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            cell.activityIndicator.stopAnimating()
            cell.imageView.setImageUrl(imageURL: imageURL)
            cell.activityIndicator.isHidden = true
        }
        
        cell.label.text = photos[indexPath.row].title
        
        return cell
    }
    
}


extension UserPhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var itemsPerRow: CGFloat {
        get {
            return 1
        }
    }
    private var sectionInsets: UIEdgeInsets {
        get {
            UIEdgeInsets(top: 10, left: 16, bottom: 30, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem + 20, height: widthPerItem + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        sectionInsets.bottom
    }
}
