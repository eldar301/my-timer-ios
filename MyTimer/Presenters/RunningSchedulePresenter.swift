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
    func finish()
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
    
    weak var runningScheduleView: RunningScheduleView?
    
    var timers: [Timer] {
        return Array(schedule.timers)
    }
    
    private var schedule: Schedule!
    
    func onViewDidLoad() {
        reloadSchedule()
    }
    
    func viewDidDisappear() {
        timerService.stop()
        running = false
    }
    
    func onStartPressed() {
        if let firstTimer = schedule.timers.first, !running {
            startTimer(withTimer: firstTimer)
            runningScheduleView?.change(timer: firstTimer, atIndex: 0)
        } else {
            runningScheduleView?.finish()
        }
    }
    
    func onStopPressed() {
        stopTimer()
        reloadSchedule()
    }
    
    private func reloadSchedule() {
        schedule = ScheduleService.instance.safeCopyActualSchedule
        runningScheduleView?.forceUpdate()
    }
    
}

private extension RunningSchedulePresenterDefault {
    
    func startTimer(withTimer timer: Timer) {
        running = true
        soundService.doSound()
        _ = timer.decreaseBySecond()
        timerService.callback = self
        timerService.run(withTimer: timer)
    }
    
    func stopTimer() {
        running = false
        timerService.callback = nil
        timerService.stop()
    }
    
}

extension RunningSchedulePresenterDefault: TimerServiceCallback {
    
    func secondElapsed(inTimer timer: Timer) {
        runningScheduleView?.change(timer: timer, atIndex: 0)
    }
    
    func timerFinished() {
        schedule.timers.removeFirst()
        runningScheduleView?.deleteTimer(atIndex: 0)
        if let nextTimer = schedule.timers.first {
            startTimer(withTimer: nextTimer)
            runningScheduleView?.change(timer: nextTimer, atIndex: 0)
        } else {
            stopTimer()
            soundService.doSound()
            runningScheduleView?.finish()
            reloadSchedule()
        }
    }
    
}

