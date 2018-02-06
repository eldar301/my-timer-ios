//
//  TimerPickerViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 01/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TimerPickerViewController: UIViewController {
    
    var presenter = PresenterManager.instance.timerPickerPresenter
    @IBOutlet weak var timerPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.timerPickerView = self
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    @IBAction func onPushClicked() {
        let minutesPicked = timerPicker.selectedRow(inComponent: 0)
        let secondsPicked = timerPicker.selectedRow(inComponent: 1)
        presenter.onPushClicked(withMinutes: minutesPicked, withSeconds: secondsPicked)
    }
}

extension TimerPickerViewController: TimerPickerView {

    func setupPicker(withMinutes minutes: Int, withSeconds seconds: Int) {
        timerPicker.selectRow(minutes, inComponent: 0, animated: true)
        timerPicker.selectRow(seconds, inComponent: 1, animated: true)
    }

}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension TimerPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        timerPicker.subviews[1].isHidden = true
        timerPicker.subviews[2].isHidden = true
        return String(format: "%02d", row)
    }
    
}
