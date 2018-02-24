//
//  SchedulePresenter.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 02/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol EditingScheduleView: class {
    func forceUpdate()
    func addTimer(timer: Timer, atIndex: Int)
    func deleteTimer(atIndex: Int)
}

protocol EditingSchedulePresenter: class {
    weak var scheduleView: EditingScheduleView? { get set }
    var timers: [Timer] { get }
    var editable: Bool { get set }
    func onViewDidAppear()
    func onTimerAdd(withMinutes: Int, withSeconds: Int)
    func onTimerDelete(atIndex: Int)
    func timerCanMove(atIndex: Int) -> Bool
    func timerDidMove(fromIndex: Int, toIndex: Int)
}

class EditingSchedulePresenterDefault: EditingSchedulePresenter {
    
    var editable: Bool = false
    
    private var schedule: Schedule = ScheduleService.instance.actualSchedule
    
    var timers: [Timer] {
        return Array(schedule.timers)
    }
    
    weak var scheduleView: EditingScheduleView?
    
    func onViewDidAppear() {
        schedule = ScheduleService.instance.actualSchedule
        scheduleView?.forceUpdate()
    }
    
    func onTimerAdd(withMinutes minutes: Int, withSeconds seconds: Int) {
        guard editable && (minutes > 0 || seconds > 0) else {
            return
        }
        let timer = Timer()
        timer.minutes = minutes
        timer.seconds = seconds
        schedule.timers.append(timer)
        scheduleView?.addTimer(timer: timer, atIndex: schedule.timers.count - 1)
    }
    
    func onTimerDelete(atIndex index: Int) {
        guard editable else {
            return
        }
        schedule.timers.remove(at: index)
        scheduleView?.deleteTimer(atIndex: index)
    }
    
    func timerCanMove(atIndex: Int) -> Bool {
        return editable
    }
    
    func timerDidMove(fromIndex from: Int, toIndex to: Int) {
        guard editable else {
            return
        }
        let movedTimer = schedule.timers[from]
        schedule.timers.remove(at: from)
        schedule.timers.insert(movedTimer, at: to)
    }
    
}

extension EditingSchedulePresenterDefault: ScheduleServiceObserver {
    
    func onActualScheduleChange() {
        self.schedule = ScheduleService.instance.actualSchedule
        self.scheduleView?.forceUpdate()
    }
    
}
