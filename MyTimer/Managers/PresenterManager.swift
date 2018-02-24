//
//  PresenterManager.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 02/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

class PresenterManager {
    
    static let instance = PresenterManager()
    
    lazy var editingSchedulePresenter: EditingSchedulePresenter = {
        let presenter = EditingSchedulePresenterDefault()
        ScheduleService.instance.observers.append(presenter)
        return presenter
    }()
    lazy var runningSchedulePresenter: RunningSchedulePresenter = RunningSchedulePresenterDefault()
    lazy var favoriteSchedulePresenter: FavoriteSchedulePresenter = FavoriteSchedulePresenterDefault()
    lazy var timerPickerPresenter: TimerPickerPresenter = TimerPickerPresenterDefault()
    lazy var saverPresenter: SaverSchedulePresenter = SaverSchedulePresenterDefault()
    
}
