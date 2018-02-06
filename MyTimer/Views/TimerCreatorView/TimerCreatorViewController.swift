//
//  ViewController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 01/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TimerCreatorViewController: UIViewController {
    
}

private extension TimerCreatorViewController {
    
    func childViewController<T: UIViewController>(withType _: T.Type) -> T? {
        for childVC in self.childViewControllers where childVC is T {
            return childVC as? T
        }
        return nil
    }

}

