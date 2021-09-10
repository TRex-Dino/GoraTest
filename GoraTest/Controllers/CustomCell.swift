//
//  CustomCell.swift
//  GoraTest
//
//  Created by Dmitry on 10.09.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: WebImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1
        
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
    }
}
