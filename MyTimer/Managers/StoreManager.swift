//
//  StoreManager.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 10.02.18.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation
import StoreKit

@available(iOS 10.3, *)
class StoreManager {
    
    private static let launchesCountKey = "launchesCountKey"
    private static var launchesCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: launchesCountKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: launchesCountKey)
        }
    }
    
    static func incrementLaunchesCount() {
        launchesCount = launchesCount + 1
    }
    
    static func requestReview() {
        if launchesCount >= 5 && launchesCount % 2 == 0 {
            SKStoreReviewController.requestReview()
        }
    }
    
}
