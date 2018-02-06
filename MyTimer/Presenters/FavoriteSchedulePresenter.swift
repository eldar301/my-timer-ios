//
//  FavoriteSchedulePresenter.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 02/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol FavoriteScheduleView: class {
    func forceUpdate()
    func deleteSchedule(atIndex: Int)
}

protocol FavoriteSchedulePresenter {
    weak var favoriteScheduleView: FavoriteScheduleView? { get set }
    var schedules: [String] { get set }
    func onViewDidAppear()
    func onSchedulePick(withTitle: String)
    func onScheduleDelete(withTitle: String, withIndex: Int)
}

class FavoriteSchedulePresenterDefault: FavoriteSchedulePresenter {
    
    var favoriteScheduleView: FavoriteScheduleView?
    
    var schedules: [String] = []
    
    func onViewDidAppear() {
        PresenterManager.instance.editingSchedulePresenter.editable = false
        schedules = ScheduleService.instance.scheduleTitles()
        favoriteScheduleView?.forceUpdate()
    }
    
    func onSchedulePick(withTitle title: String) {
        let schedule = ScheduleService.instance.schedule(withTitle: title)
        ScheduleService.instance.actualSchedule = schedule
    }
    
    func onScheduleDelete(withTitle title: String, withIndex index: Int) {
        ScheduleService.instance.delete(withTitle: title)
        self.schedules.remove(at: index)
        favoriteScheduleView?.deleteSchedule(atIndex: index)
    }
    
}