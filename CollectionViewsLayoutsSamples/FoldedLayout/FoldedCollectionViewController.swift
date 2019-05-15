//
//  FoldedCollectionViewController.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

class FoldedCollectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var foldingTypePicker: UIPickerView!
    
    let layout = FoldedCollectionFlowLayout()
    let collectionDataSource = FoldedCollectionDataSource()
    let pickerData = FoldingType.allCases.map{ $0.rawValue }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}


// MARK: - Private
private extension FoldedCollectionViewController {
    func configure() {
        self.view.backgroundColor = .black
        
        foldingTypePicker.delegate = self
        foldingTypePicker.dataSource = self
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = collectionDataSource
        collectionView.isPagingEnabled = true
        
        if let type = FoldingType(rawValue: pickerData.first ?? "straightUp") {
            layout.foldingType = type
        }
        collectionView.collectionViewLayout = layout
    }
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension FoldedCollectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: self.pickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow])
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // selected value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = pickerData[row]
        if let type = FoldingType(rawValue: value) {
            layout.foldingType = type
        }
    }
}

