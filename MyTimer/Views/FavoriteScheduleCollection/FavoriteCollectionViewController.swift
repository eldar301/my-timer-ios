//
//  FavoriteCollectionViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 02/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class FavoriteCollectionViewController: UICollectionViewController {
    
    var presenter = PresenterManager.instance.favoriteSchedulePresenter
    private var schedules: [String] = []

    private let reuseIdentifier = "FavoriteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGestureRecognizer.direction = .down
        self.collectionView?.addGestureRecognizer(swipeGestureRecognizer)

        self.collectionView!.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        if let tabBarHeight = tabBarController?.tabBar.frame.height {
            let tabBarInsets = UIEdgeInsetsMake(0, 0, tabBarHeight, 0)
            collectionView?.contentInset = tabBarInsets
        }
        
        presenter.favoriteScheduleView = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.onViewDidAppear()
    }
    
}

extension FavoriteCollectionViewController: FavoriteScheduleView {
    
    func forceUpdate() {
        self.schedules = presenter.schedules
        collectionView?.reloadData()
    }
    
    func deleteSchedule(atIndex index: Int) {
        self.schedules = presenter.schedules
        collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
}

extension FavoriteCollectionViewController {
    
    // MARK: UISwipeGestureRecognizer logic
    
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        guard let toDeleteIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        let cell = collectionView?.cellForItem(at: toDeleteIndexPath) as? FavoriteCollectionViewCell
        if let title = cell?.title.text {
            presenter.onScheduleDelete(withTitle: title, withIndex: toDeleteIndexPath.row)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedules.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let favoriteCell = cell as? FavoriteCollectionViewCell {
            favoriteCell.title.text = schedules[indexPath.row]
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell {
            presenter.onSchedulePick(withTitle: cell.title.text!)
        }
    }

}

extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.contentSize.height
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
}
