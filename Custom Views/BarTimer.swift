//
//  BarTimer.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIBarButtonItem
import UIKit.UINavigationItem
import UIKit.UIColor

class BarTimer: UIBarButtonItem {
    
    private var countdownTimer: Timer?
    
    private var fullTime: Int!
    
    public var timeLeft: Int!
    
    convenience init(time: Int) {
        self.init()
        
        self.fullTime = time
        
        self.timeLeft = time
            
        self.setTitleTextAttributes([key.font: UIFont.defaultFont(size: 18, weight: .bold)], for: .normal)
        
    }
    
    @objc
    public func startTimer() {
        
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.title = String(timeLeft!)
        
    }
    
    
    @objc
    private func updateTimer() {
        
        timeLeft -= 1
        
        title = String(timeLeft!)
        
        if (timeLeft <= 5) {
            
            HapticFeedback.shared.warningFeedback()
        
            if (4...5 ~= timeLeft) { tintColor = .Yellow }
        
            if (timeLeft <= 3) { tintColor = .Red }
        
            if (timeLeft == 0) { endTimer(); nextQuestion() }
        
       }
    }
    
    @objc
    public func endTimer() {
        
        guard (countdownTimer != nil) else { return }
        
        countdownTimer!.invalidate()
        countdownTimer = nil
        
        timeLeft = fullTime
        
        tintColor = .OffWhite
        
    }
    
    @objc
    public func freezeTimer() {
        
        guard (countdownTimer != nil) else { return }
        
        countdownTimer?.invalidate()
        
    }
    
    
    @objc
    private func nextQuestion() {       
        
       autoreleasepool(invoking: {
        
            DispatchQueue.main.async { NotificationCenter.default.post(name: "PlayerDidNotAnswerInTime") }
        
       })
        
    }
    
    deinit { endTimer() }
    
}
