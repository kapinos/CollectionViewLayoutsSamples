//
//  FoldedCellsViewController.swift
//  CollectionViewsLayoutsSamples
//
//  Created by Developer on 5/14/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class FoldedCellsViewController: UIViewController {
    
    
    let pickerData = FoldingType.allCases.map{ $0.rawValue }
    var layout = FoldedCollectionViewLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        foldingTypePicker.delegate = self
        foldingTypePicker.dataSource = self
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        if let type = FoldingType(rawValue: pickerData.first ?? "straightUp") {
            layout.foldingType = type
        }
        collectionView.collectionViewLayout = layout
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FoldedCellsViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foldedCell", for: indexPath)
        cell.layer.cornerRadius = 2.0
        cell.backgroundColor = .yellow
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension FoldedCellsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
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
