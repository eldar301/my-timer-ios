//
//  AutoAdjustingBackgroundViewToTopOfStatusBar.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 06.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class ViewControllerWithAutoAdjustingBackgroundViewToTopOfStatusBar: UIViewController {
    
    weak var backgroundViewToTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundViewToTopConstraint(withSize: view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureBackgroundViewToTopConstraint(withSize: size)
    }
    
    private let iphoneXDimensionHeight: CGFloat = 2436
    
    // fix with iphone x
    private func configureBackgroundViewToTopConstraint(withSize size: CGSize) {
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return
        }
        if size.width > size.height {
            self.backgroundViewToTopConstraint?.constant = 0
        } else {
            if iphoneXDimensionHeight != UIScreen.main.nativeBounds.height {
                self.backgroundViewToTopConstraint?.constant = 20
            } else {
                self.backgroundViewToTopConstraint?.constant = 44
            }
        }
    }
    
}

