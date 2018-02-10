//
//  TimerFlowLayout.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 10.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TimerFlowLayout: UICollectionViewFlowLayout {
    
    private var insertingIndexPaths: [IndexPath] = []
    private var deletingIndexPaths: [IndexPath] = []
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
        
        for item in updateItems {
            if let insertToIndexPath = item.indexPathAfterUpdate, item.updateAction == .insert {
                insertingIndexPaths.append(insertToIndexPath)
            }
            if let deleteFromIndexPath = item.indexPathBeforeUpdate, item.updateAction == .delete {
                deletingIndexPaths.append(deleteFromIndexPath)
            }
        }
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        if insertingIndexPaths.contains(itemIndexPath) {
            attributes?.transform = CGAffineTransform(translationX: collectionView!.frame.width, y: -40)
        }
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        
        if deletingIndexPaths.contains(itemIndexPath) {
            attributes?.transform = CGAffineTransform(translationX: -collectionView!.frame.width, y: 0)
        }
        
        return attributes
    }
}
