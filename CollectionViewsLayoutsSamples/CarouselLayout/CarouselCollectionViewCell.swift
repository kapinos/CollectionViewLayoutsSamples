//
//  CarouselCollectionViewCell.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    func configure() {
        contentView.backgroundColor = .green
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 1
    }
}
