//
//  RoundEdgeView.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 06.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import UIKit

@IBDesignable
class RoundEdgeView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
