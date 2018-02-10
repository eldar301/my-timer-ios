//
//  TimerCollectionViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 01/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TimerCollectionViewController: UICollectionViewController {
    
    open var timers: [Timer] = []
    
    private let cellReuseIdentifier = "CapsuleCell"
    private let headerReuseIdentifier = "TimerCollectionHeaderView"
    private let footerReuseIdentifier = "TimerCollectionFooterView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.setCollectionViewLayout(TimerFlowLayout(), animated: true)
        
        collectionView?.register(UINib(nibName: "TimerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView?.register(UINib(nibName: "HeaderCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        collectionView?.register(UINib(nibName: "FooterCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier)
    }
    
}

extension TimerCollectionViewController {

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timers.count
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        if let capsuleCell = cell as? TimerCollectionViewCell {
            let timer = timers[indexPath.row]
            capsuleCell.timerLabel.text = timer.description
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        default:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)
        }
    }
    
}

extension TimerCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fillScreenWidth = collectionView.frame.width
        return CGSize(width: fillScreenWidth, height: 40)
    }

}
