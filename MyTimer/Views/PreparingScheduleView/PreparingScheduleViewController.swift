//
//  PreparingScheduleViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 04/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class PreparingScheduleViewController: UIViewController {

    var presenter = PresenterManager.instance.saverPresenter
    
    @IBAction func addToFavoritesPressed() {
        let alert = UIAlertController(title: "Save timer", message: "How would you name it", preferredStyle: .alert)
        
        let enterTitleAction = UIAlertAction(title: "Save", style: .default) { (_) in
            let textField = alert.textFields![0]
            self.presenter.save(withTitle: textField.text!)
        }
        enterTitleAction.isEnabled = false
        alert.addAction(enterTitleAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the title"
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: { (_) in
                enterTitleAction.isEnabled = textField.text != ""
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    let startString = NSAttributedString(string: "Start")
    let stopString = NSAttributedString(string: "Stop")
    
    @IBAction func startStopPressed(_ sender: UIButton) {
        if sender.attributedTitle(for: .normal) == startString {
            PresenterManager.instance.runningSchedulePresenter.onStartPressed()
            sender.setAttributedTitle(stopString, for: .normal)
        } else {
            PresenterManager.instance.runningSchedulePresenter.onStopPressed()
            sender.setAttributedTitle(startString, for: .normal)
        }
    }
}
