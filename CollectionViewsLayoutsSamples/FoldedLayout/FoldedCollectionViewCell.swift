//
//  FoldedCollectionViewCell.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class FoldedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with image: UIImage?) {
        self.imageView.image = image
        self.layer.cornerRadius = 2.0
        self.backgroundColor = .yellow
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
}
