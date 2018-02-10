//
//  RunningScheduleCollectionViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 03/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class RunningScheduleCollectionViewController: TimerCollectionViewController {
    
    var presenter = PresenterManager.instance.runningSchedulePresenter

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true
        
        presenter.runningScheduleView = self
        presenter.onViewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false
        
        presenter.viewDidDisappear()
    }

}

extension RunningScheduleCollectionViewController: RunningScheduleView {
    
    func finish() {
        if let preparingVC = self.parent as? PreparingScheduleViewController {
            preparingVC.setStartTitle()
        }
    }
    
    
    func forceUpdate() {
        self.timers = presenter.timers
        collectionView?.reloadData()
    }
    
    func deleteTimer(atIndex index: Int) {
        self.timers = presenter.timers
        collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func change(timer: Timer, atIndex: Int) {
        let toChangeIndexPath = IndexPath(row: atIndex, section: 0)
        if let cell = collectionView?.cellForItem(at: toChangeIndexPath) as? TimerCollectionViewCell {
            cell.timerLabel.text = timer.description
        }
    }
    
}
