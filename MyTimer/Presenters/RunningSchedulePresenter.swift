//
//  RunningSchedulePresenter.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 03/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol RunningScheduleView: class {
    func forceUpdate()
    func deleteTimer(atIndex: Int)
    func change(timer: Timer, atIndex: Int)
}

protocol RunningSchedulePresenter: class {
    weak var runningScheduleView: RunningScheduleView? { get set }
    var timers: [Timer] { get }
    func onViewDidLoad()
    func viewDidDisappear()
    func onStartPressed()
    func onStopPressed()
}

class RunningSchedulePresenterDefault: RunningSchedulePresenter {

    private var timerService = TimerService()
    private var soundService = SoundService()
    private var running: Bool = false
    
    var runningScheduleView: RunningScheduleView?
    
    var timers: [Timer] {
        return Array(schedule.timers)
    }
    
    private var schedule: Schedule!
    
    func onViewDidLoad() {
        schedule = ScheduleService.instance.safeCopyActualSchedule
        runningScheduleView?.forceUpdate()
        timerService.callback = self
    }
    
    func viewDidDisappear() {
        timerService.stop()
        running = false
    }
    
    func onStartPressed() {
        if let firstTimer = schedule.timers.first, !running {
            running = true
            soundService.doSound()
            timerService.run(withTimer: firstTimer)
        }
    }
    
    func onStopPressed() {
        running = false
        timerService.stop()
        schedule = ScheduleService.instance.safeCopyActualSchedule
        runningScheduleView?.forceUpdate()
    }
    
}

extension RunningSchedulePresenterDefault: TimerServiceCallback {
    
    func secondElapsed(inTimer timer: Timer) {
        runningScheduleView?.change(timer: timer, atIndex: 0)
    }
    
    func timerFinished() {
        soundService.doSound()
        schedule.timers.removeFirst()
        runningScheduleView?.deleteTimer(atIndex: 0)
        if let nextTimer = schedule.timers.first {
            timerService.run(withTimer: nextTimer)
        } else {
            running = false
        }
    }
    
}

