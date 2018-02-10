//
//  PreparingScheduleViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 04/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class PreparingScheduleViewController: ViewControllerWithAutoAdjustingBackgroundViewToTopOfStatusBar {

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var backgroundTopConstraints: NSLayoutConstraint!
    
    var presenter = PresenterManager.instance.saverPresenter
    
    override func viewDidLoad() {
        self.backgroundViewToTopConstraint = backgroundTopConstraints
        
        super.viewDidLoad()
    }
    
    let alertTitle = NSLocalizedString("Save timer", comment: "PreparingScheduleViewController")
    let alertMessage = NSLocalizedString("How would you name it", comment: "PreparingScheduleViewController")
    let alertEnterTitleAction = NSLocalizedString("Save", comment: "PreparingScheduleViewController")
    let alertEnterTitleTextFieldPlaceholder = NSLocalizedString("Enter the title", comment: "PreparingScheduleViewController")
    let alertCancelAction = NSLocalizedString("Cancel", comment: "PreparingScheduleViewController")
    
    @IBAction func addToFavoritesPressed() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let enterTitleAction = UIAlertAction(title: alertEnterTitleAction, style: .default) { (_) in
            let textField = alert.textFields![0]
            self.presenter.save(withTitle: textField.text!)
        }
        enterTitleAction.isEnabled = false
        alert.addAction(enterTitleAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = self.alertEnterTitleTextFieldPlaceholder
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: { (_) in
                enterTitleAction.isEnabled = textField.text != ""
            })
        }
        
        let cancelAction = UIAlertAction(title: alertCancelAction, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private let startString = NSLocalizedString("Start", comment: "PreparingScheduleViewController")
    private let stopString = NSLocalizedString("Stop", comment: "PreparingScheduleViewController")
    
    @IBAction func startStopPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == startString {
            sender.setTitle(stopString, for: .normal)
            PresenterManager.instance.runningSchedulePresenter.onStartPressed()
        } else {
            sender.setTitle(startString, for: .normal)
            PresenterManager.instance.runningSchedulePresenter.onStopPressed()
        }
    }
    
    func setStartTitle() {
        startStopButton.setTitle(startString, for: .normal)
    }
}
