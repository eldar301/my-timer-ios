//
//  ViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 01/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TimerCreatorViewController: ViewControllerWithAutoAdjustingBackgroundViewToTopOfStatusBar {
    
    @IBOutlet weak var backgroundTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        self.backgroundViewToTopConstraint = backgroundTopConstraint
        super.viewDidLoad()
        
        if #available(iOS 10.3, *) {
            StoreManager.requestReview()
        }
    }
    
}

