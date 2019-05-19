//
//  CarouselCollectionViewController.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class CarouselCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let layout = CarouselCollectionFlowLayout()
    let collectionDataSource = CarouselCollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
}


// MARK: - Private
private extension CarouselCollectionViewController {
    func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = collectionDataSource
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.zoomFactor = 0.4
        collectionView.collectionViewLayout = layout
    }
}
