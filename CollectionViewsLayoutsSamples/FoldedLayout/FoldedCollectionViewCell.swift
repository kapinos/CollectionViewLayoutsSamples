//
//  FoldedCollectionViewCell.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class FoldedCollectionViewCell: UICollectionViewCell {
    func configure() {
        self.layer.cornerRadius = 2.0
        self.backgroundColor = .yellow
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
}
