//
//  SoundService.swift
//  MyTimer
//
//  Created by Eldar Goloviznin on 04/02/2018.
//  Copyright © 2018 Eldar Goloviznin. All rights reserved.
//

import Foundation
import AVFoundation

class SoundService {
    
    private let vibrateID: SystemSoundID = 4095
    private let soundID: SystemSoundID = 1114

    func doSound() {
        AudioServicesPlaySystemSound(soundID)
        AudioServicesPlaySystemSound(vibrateID)
    }
    
}
