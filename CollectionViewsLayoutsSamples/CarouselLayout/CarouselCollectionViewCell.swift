//
//  CarouselCollectionViewCell.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with image: UIImage?) {
        self.imageView.image = image
        contentView.backgroundColor = .green
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 1
    }
}
