//
//  FoldedCollectionDataSource.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class FoldedCollectionDataSource: NSObject, UICollectionViewDataSource {
    let images = [UIImage(named: "star_0"), UIImage(named: "star_1"), UIImage(named: "star_2"),
                  UIImage(named: "star_3"), UIImage(named: "star_4"), UIImage(named: "star_5")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foldedCell", for: indexPath) as? FoldedCollectionViewCell else { return FoldedCollectionViewCell() }
        
        if images.indices.contains(indexPath.row) {
            cell.configure(with: images[indexPath.row])
        }
        return cell
    }
}
