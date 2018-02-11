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
        self.collectionView!.addGestureRecognizer(swipeGestureRecognizer)

        self.collectionView!.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        // Page Control
        let insetsForPageController = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        self.collectionView!.contentInset = insetsForPageController
        
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
        if self.schedules.count == 0 {
            addPlaceholder()
        } else {
            removePlaceholder()
        }
        collectionView?.reloadData()
    }
    
    func deleteSchedule(atIndex index: Int) {
        self.schedules = presenter.schedules
        if self.schedules.count == 0 {
            addPlaceholder()
        } else {
            removePlaceholder()
        }
        collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    private func addPlaceholder() {
        guard self.collectionView?.backgroundView == nil else {
            return
        }
        guard let backgroundView = UINib(nibName: "PlaceholderView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.collectionView?.backgroundView = backgroundView
        backgroundView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            backgroundView.alpha = 1
        }
    }
    
    private func removePlaceholder() {
        self.collectionView?.backgroundView = nil
    }
    
}

extension FavoriteCollectionViewController {
    
    // MARK: UISwipeGestureRecognizer logic
    
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        guard let toDeleteIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        presenter.onScheduleDelete(withIndex: toDeleteIndexPath.row)
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
        return CGSize(width: itemHeight * 2, height: itemHeight)
    }
    
}
