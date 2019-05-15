//
//  FoldedCollectionFlowLayout.swift
//  CollectionViewsLayoutsSamples
//
//  Created by AnKis on 5/14/19.
//  Copyright © 2019 AnKis. All rights reserved.
//

import UIKit

enum FoldingType: String, CaseIterable {
    case straightUp
    case straightDown
    case rightUp
    case rightDown
}


class FoldedCollectionFlowLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    public var itemSize = CGSize(width: 200, height: 300) {
        didSet {
            invalidateLayout()
        }
    }
    
    public var spacing: CGFloat = 10.0 {
        didSet {
            invalidateLayout()
        }
    }
    
    public var maximumVisibleItems: Int = 4 {
        didSet {
            invalidateLayout()
        }
    }
    
    public var foldingType = FoldingType.straightUp {
        didSet {
            invalidateLayout()
        }
    }
    
    public var backCardsAlpha = CGFloat(1) {
        didSet {
            invalidateLayout()
        }
    }
    
    // MARK: UICollectionViewLayout
    override open var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width:    collectionView.bounds.width * itemsCount,
                      height:   collectionView.bounds.height)
    }
    
    override open func prepare() {
        super.prepare()
        assert(collectionView?.numberOfSections == 1, "Only one section for this collectionView's layout is supported")
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        
        let minVisibleIndex = max(Int(collectionView.contentOffset.x)/Int(collectionView.bounds.width), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, collectionView.numberOfItems(inSection: 0))
        
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let shiftByX = CGFloat(Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width))
        
        let percentageDeltaOffset = shiftByX / collectionView.bounds.width
        
        let visibleIndices = stride(from: minVisibleIndex, to: maxVisibleIndex, by: 1)
        
        let attributes: [UICollectionViewLayoutAttributes] = visibleIndices.map { index in
            return getLayoutAttributesForItem(indexPath:             IndexPath(item: index, section: 0),
                                              minVisibleIndex:       minVisibleIndex,
                                              contentCenterX:        contentCenterX,
                                              shiftByX:              shiftByX,
                                              percentageDeltaOffset: percentageDeltaOffset)
        }
        
        return attributes
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


// MARK: - Layout
private extension FoldedCollectionFlowLayout {
    func getLayoutAttributesForItem(indexPath: IndexPath,
                                    minVisibleIndex: Int,
                                    contentCenterX: CGFloat,
                                    shiftByX: CGFloat,
                                    percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
        guard let collectionView = self.collectionView else { return attributes }
        
        let visibleIndex = CGFloat(indexPath.row - minVisibleIndex)
        
        let midY = collectionView.bounds.midY
        var center = CGPoint(x: contentCenterX, y: midY)
        
        switch self.foldingType {
        case .straightUp:
            center = CGPoint(x: contentCenterX,
                             y: midY - spacing * visibleIndex)
            
        case .straightDown:
            center = CGPoint(x: contentCenterX,
                             y: midY + spacing * visibleIndex)
        case .rightDown:
            center = CGPoint(x: contentCenterX + spacing * visibleIndex,
                             y: midY + spacing * visibleIndex)
        case .rightUp:
            center = CGPoint(x: contentCenterX + spacing * visibleIndex,
                             y: midY - spacing * visibleIndex)
        }
        
        attributes.center = center
        attributes.zIndex = maximumVisibleItems - Int(visibleIndex)
        
        // count size and center on moving for visible cells
        switch visibleIndex {
        case 0:
            attributes.center.x -= shiftByX
            attributes.alpha = 1
            attributes.size = itemSize
            
        case 1..<CGFloat(maximumVisibleItems):
            let refinedValues = getRefined(center: center, for: visibleIndex, with: percentageDeltaOffset)
            
            attributes.center = refinedValues.center
            attributes.size = refinedValues.size
            attributes.alpha = self.backCardsAlpha
            
            if visibleIndex == CGFloat(maximumVisibleItems) - 1 {
                attributes.alpha = percentageDeltaOffset
            }
            
        default:  break
        }
        
        return attributes
    }
    
    func getRefined(center: CGPoint, for index: CGFloat, with percentageDeltaOffset: CGFloat) -> (center: CGPoint, size: CGSize) {
        var center = center
        var size = self.itemSize
        
        switch self.foldingType {
        case .straightUp:
            center.y += spacing * percentageDeltaOffset
            size = CGSize(width: itemSize.width - spacing * (index - percentageDeltaOffset), height: itemSize.height)
            
        case .straightDown:
            center.y -= spacing * percentageDeltaOffset
            size = CGSize(width: itemSize.width - spacing * (index - percentageDeltaOffset), height: itemSize.height)
            
        case .rightDown:
            center.x -= spacing * percentageDeltaOffset
            center.y -= spacing * percentageDeltaOffset
            
        case .rightUp:
            center.x -= spacing * percentageDeltaOffset
            center.y += spacing * percentageDeltaOffset
        }
        return (center, size)
    }
}

