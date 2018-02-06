//
//  SaverPresenter.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 04/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol SaverSchedulePresenter {
    func save(withTitle: String)
}

class SaverSchedulePresenterDefault: SaverSchedulePresenter {
    
    func save(withTitle title: String) {
        guard title != "" else {
            return
        }
        let schedule = ScheduleService.instance.actualSchedule
        schedule.title = title
        ScheduleService.instance.save(schedule: schedule)
    }
    
}
