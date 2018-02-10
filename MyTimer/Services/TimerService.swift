//
//  TimerService.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 04/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol TimerServiceCallback {
    func secondElapsed(inTimer: MyTimer.Timer)
    func timerFinished()
}

class TimerService {
    
    var callback: TimerServiceCallback?
    
    private var timer: Foundation.Timer?
    
    func run(withTimer myTimer: MyTimer.Timer) {
        self.timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onCountFired(_:)), userInfo: myTimer, repeats: true)
    }
    
    @objc private func onCountFired(_ timer: Foundation.Timer) {
        guard let myTimer = timer.userInfo as? MyTimer.Timer else {
            return
        }
        if myTimer.decreaseBySecond() {
            self.callback?.secondElapsed(inTimer: myTimer)
            return
        } else {
            self.stop()
            self.callback?.timerFinished()
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}
