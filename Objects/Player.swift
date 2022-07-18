//
//  Player.swift
//  Millenials
//
//  Created by Ronaldo Santana on 28/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

/*
    // Keys usadas
    // PlayerAnsweredCorrectly
    // PlayerAnsweredIncorrectly
    // PlayerHasFinished
*/


class Player: NSObject {
    
    public var name: String!
    public var picture: UIImage?
    
    public var points: Int = 0
    
    public var rightAnswerStreak: Int = 0
    private var questions = Dictionary<Question, Dictionary<String, Bool>>()
    
    public var questionsToAnswer: [Question]! {
        
        didSet {
            
            if (self.questionsToAnswer.count == 0) {
                
                self.rightAnswerStreak = 0
                
                self.hasPlayedRound = true
                
            }
            
        }
        
    }
    
    
    public var isCurrentPlayer: Bool = false {
        
        willSet {
            
            if (newValue == true) {
                
                self.addObservers()
                
                return
            }
            
            self.removeObservers()
            
        }
        
    }
    
    public var hasPlayedRound: Bool = false {        
        
        didSet {
            
            if (self.hasPlayedRound == true) {
                
                self.notificationCenter.post(name: "PlayerHasFinished")
                
            }
            
        }
        
    }
    
    lazy private var notificationCenter: NotificationCenter = {
       
        return NotificationCenter.default
        
    }()
    
    var millenials: Millenials!
    
    
    required init(playerName: String) {
        super.init()
        
        self.name = playerName
        
    }
    
    convenience init(playerName: String, millenialsObj: Millenials) {
        self.init(playerName: playerName)
        
        self.millenials = millenialsObj
    }
    
    @objc
    private func incorrectAnswer(_ notification: NSNotification) {
        
        rightAnswerStreak = 0
        
        if let playerAnswer = notification.userInfo?["answer"] as? String {
            
            questions[questionsToAnswer.first!] = [playerAnswer: false]
            
        } else {
            
            questions[questionsToAnswer.first!] = ["Não respondeu": false]
            
        }
        
        nextQuestion()
        
    }
    
    @objc
    private func correctAnswer() {
        
        rightAnswerStreak += 1
        
        questions[questionsToAnswer.first!] = [questionsToAnswer.first!.rightAnswer: true]
        
        addPoints()
        
        nextQuestion()
        
    }
    
    private func addPoints() {
        
        var multiplier: Int = 1
        
        if (rightAnswerStreak >= 3) {
            
            multiplier = 2
            
        }
        
        points += (millenials.gameRound * 100) * multiplier
        
    }
    
    @objc
    private func nextQuestion() {
        
        questionsToAnswer.removeFirst()        
        
    }
    
    
    
    private func addObservers() {
        
        notificationCenter.addObserver(self, selector: #selector(correctAnswer), name: notification(name: "PlayerAnsweredCorrectly"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(incorrectAnswer(_:)), name: notification(name: "PlayerAnsweredIncorrectly"), object: nil)
     
    }
    
    private func removeObservers() {
        notificationCenter.removeObserver(self)
    }
    
    
   

}
