//
//  Schedule.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 02/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation
import RealmSwift

class Schedule: Object {
    
    @objc dynamic var title: String = ""
    var timers = List<Timer>()
    
    var safeCopy: Schedule {
        let copy = Schedule()
        copy.title = self.title
        for timer in self.timers {
            let copiedTimer = Timer()
            copiedTimer.minutes = timer.minutes
            copiedTimer.seconds = timer.seconds
            copy.timers.append(copiedTimer)
        }
        return copy
    }
    
}

class Timer: Object {
    
    @objc dynamic var minutes: Int = 0
    @objc dynamic var seconds: Int = 0
    
    func decreaseBySecond() -> Bool {
        if seconds > 0 {
            seconds = seconds - 1
            return true
        } else {
            if minutes > 0 {
                seconds = 59
                minutes = minutes - 1
                return true
            } else {
                return false
            }
        }
    }
    
    override var description: String {
        return String(format: "%02d", minutes) + ":" + String.init(format: "%02d", seconds)
    }
    
}
