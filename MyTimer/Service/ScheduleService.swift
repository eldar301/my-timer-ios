//
//  ScheduleService.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 03/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation
import RealmSwift

protocol ScheduleServiceObserver {
    func onActualScheduleChange()
}

class ScheduleService {
    
    static let instance = ScheduleService()
    
    var actualSchedule: Schedule {
        didSet {
            for observer in observers {
                observer.onActualScheduleChange()
            }
        }
    }
    
    var safeCopyActualSchedule: Schedule {
        return actualSchedule.safeCopy
    }
    
    var observers: [ScheduleServiceObserver] = []
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
        
        actualSchedule = Schedule()
        for multiplier in 1...5 {
            let timer = Timer()
            timer.minutes = 0
            timer.seconds = 5 * multiplier
            actualSchedule.timers.append(timer)
        }
    }
    
    func scheduleTitles() -> [String] {
        let objects = realm.objects(Schedule.self)
        var titles = [String]()
        for object in objects {
            titles.append(object.title)
        }
        return titles
    }
    
    func schedule(withTitle title: String) -> Schedule {
        if let schedule = realm.objects(Schedule.self).filter({ $0.title == title }).first {
            return schedule.safeCopy
        }
        return actualSchedule
    }

    func save(schedule: Schedule) {
        try! realm.write {
            realm.add(schedule.safeCopy)
        }
    }
    
    func delete(withTitle title: String) {
        if let storedSchedule = realm.objects(Schedule.self).filter({ $0.title == title }).first {
            try! realm.write {
                realm.delete(storedSchedule)
            }
        }
    }
    
}
