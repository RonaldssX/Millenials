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
    
    private var fullTime: Int! {
        
        didSet {
            
            timeLeft = self.fullTime
            
        }
        
    }
    
    public var timeLeft: Int!
    
    public var superview: UINavigationItem?
    
    convenience init(time: Int) {
        self.init()
        
        defer {
        
        self.fullTime = time
            
        }
        
    }
    
    @objc
    public func startTimer() {
        
        guard (countdownTimer == nil) else {
            
            countdownTimer!.invalidate()
            countdownTimer = nil
            
            timeLeft = fullTime
            
            tintColor = UIColor.NavigationBar.barTintColor
            
            startTimer()
            return
            
        }
        
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.title = "\(timeLeft!)"
        
    }
    
    
    @objc
    private func updateTimer() {
        
        timeLeft -= 1
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.alpha = 0.0
            
        }, completion: {(completed) in
           
            self.title = "\(self.timeLeft!)"
            
            UIView.animate(withDuration: 0.1, animations: {
                
                self.alpha = 1.0
                
            })
            
        })
        
        
        if (timeLeft <= 5) {
            
            tintColor = UIColor.red
            
        }
        
        
        if (timeLeft == 0) {
            
            countdownTimer!.invalidate()
            
            nextQuestion()
            
        }
        
        
    }
    
    @objc
    public func stopTimer() {
        
        countdownTimer!.invalidate()
        
    }
    
    
    @objc
    private func nextQuestion() {
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerDidNotAnswerInTime")
            
        }
        
    }
    
}
