//
//  EditingScheduleCollectionViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 03/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class EditingScheduleCollectionViewController: TimerCollectionViewController {
    
    var presenter = PresenterManager.instance.editingSchedulePresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Detecting to move timers
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        collectionView?.addGestureRecognizer(longPressGestureRecognizer)
        
        // Detecting to fast deleting timers
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGestureRecognizer.direction = .left
        collectionView?.addGestureRecognizer(swipeGestureRecognizer)
        
        presenter.scheduleView = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.onViewDidAppear()
    }
    
}

extension EditingScheduleCollectionViewController: EditingScheduleView {
    
    func forceUpdate() {
        self.timers = presenter.timers
        collectionView?.reloadData()
    }
    
    func addTimer(timer: Timer, atIndex index: Int) {
        self.timers = presenter.timers
        let insertToIndexPath = IndexPath(row: index, section: 0)
        collectionView?.insertItems(at: [insertToIndexPath])
        collectionView?.scrollToItem(at: insertToIndexPath, at: .bottom, animated: true)
    }
    
    func deleteTimer(atIndex index: Int) {
        self.timers = presenter.timers
        collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
}

extension EditingScheduleCollectionViewController {
    
    // MARK: UISwipeGestureRecognizer logic
    
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        guard let toDeleteIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        presenter.onTimerDelete(atIndex: toDeleteIndexPath.row)
    }
    
    // MARK: UILongPressGestureRecognizer logic
    
    @objc func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return presenter.timerCanMove(atIndex: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.timerDidMove(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        self.timers = presenter.timers
    }
    
}
