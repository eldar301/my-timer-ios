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
        self.timer = Foundation.Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            if myTimer.decreaseBySecond() {
                self.callback?.secondElapsed(inTimer: myTimer)
                return
            } else {
                self.stop()
                self.callback?.timerFinished()
            }
        })
    }
    
    func stop() {
        timer?.invalidate()
    }
}
