//
//  OrientationManager.swift
//  Millenials
//
//  Created by Ronaldo Santana on 07/12/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

final class OrientationManager {
    
    static func lockPortrait() {
        if let delegate = UIApplication.shared.delegate as? MillenialsDelegate {
            delegate.orientation = .portrait
        }
        /* rotates the device to portrait mode */
        let orientationVal = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientationVal, forKey: "orientation")
    }
    
    static func unlockPortrait() {
        if let delegate = UIApplication.shared.delegate as? MillenialsDelegate {
            delegate.orientation = .allButUpsideDown
        }
    }
    
    
}
