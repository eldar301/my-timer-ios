//
//  TransparentNavigationController.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 06.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

}
