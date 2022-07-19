//
//  HapticFeedback.swift
//  Millenials
//
//  Created by Ronaldo Santana on 11/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import AudioToolbox
import UIKit

public enum FeedbackType {
    
    case warning
    case error
    case success
    
}

final class HapticFeedback {
    
    static let shared = HapticFeedback()
    
    private let supportsHaptic = DeviceType.shared.supportsHaptic
    
    public func warningFeedback() {
        
        guard (supportsHaptic) else { return AudioServicesPlaySystemSound(1520) }
        
        if #available(iOS 10.0, *) {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.notificationOccurred(.warning)
        }
        
    }
    
    public func errorFeedback() {
        
        guard (supportsHaptic) else { return AudioServicesPlaySystemSound(1520) }
        
        if #available(iOS 10.0, *) {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.notificationOccurred(.error)
        }
        
    }
    
    public func sucessFeedback() {
        
        guard (supportsHaptic) else { return AudioServicesPlaySystemSound(1519) }
        
        if #available(iOS 10.0, *) {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.notificationOccurred(.success)
        }
        
    }
    
    public func feedback(feedbackType: FeedbackType, repeats: Int) {
        
        guard (repeats > 0) else { return }
        
        for _ in 1...repeats {
            
            if (feedbackType == .warning) { self.warningFeedback(); continue }
            if (feedbackType == .error)   { self.errorFeedback();   continue }
            if (feedbackType == .success) { self.sucessFeedback();  continue }
            
        }
        
    }
}
