//
//  TimerPickerPresenter.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 03/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol TimerPickerView: class {
    func setupPicker(withMinutes: Int, withSeconds: Int)
}

protocol TimerPickerPresenter {
    weak var timerPickerView: TimerPickerView? { get set }
    func viewDidLoad()
    func viewDidAppear()
    func onPushClicked(withMinutes: Int, withSeconds: Int)
}

class TimerPickerPresenterDefault: TimerPickerPresenter {
    
    weak var timerPickerView: TimerPickerView?
    
    func viewDidLoad() {
        timerPickerView?.setupPicker(withMinutes: 0, withSeconds: 30)
    }
    
    func viewDidAppear() {
        PresenterManager.instance.editingSchedulePresenter.editable = true
    }
    
    func onPushClicked(withMinutes minutes: Int, withSeconds seconds: Int) {
        PresenterManager.instance.editingSchedulePresenter.onTimerAdd(withMinutes: minutes, withSeconds: seconds)
    }

}
