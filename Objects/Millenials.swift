//
//  Millenials.swift
//  Millenials
//
//  Created by Ronaldo Santana on 28/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
import Foundation


class Millenials: NSObject {
    
    private var players: [Player]! {
        
        didSet {
            
            for player in self.players {
                
                player.millenials = self
                
            }
            
            currentPlayer = self.players.randomElement()!
            
        }
        
    }
    
    public var currentPlayer: Player! {
        
        willSet {
            
            if (self.currentPlayer == nil) {
                
                return
                
            }
            
            self.currentPlayer.isCurrentPlayer.toggle()
            
        }
        
        didSet {
            
            if (self.currentPlayer == nil) {
                
                return
                
            }
            
            self.currentPlayer.isCurrentPlayer.toggle()
            self.currentPlayer.questionsToAnswer = questions.roundQuestions
            
        }        
        
    }
    
    private var questions: QuestionMaster = QuestionMaster()
    
    
    public var gameRound: Int! {
        
        didSet {
            
            questions.gameRound = self.gameRound
            
        }
        
    }
    
    
    lazy private var notificationCenter: NotificationCenter = {
       
        return NotificationCenter.default
        
    }()
    
    
    required init(players: [Player]) {
        
        super.init()
        
        addObservers()
       
        defer {
            
        self.gameRound = 1
        
        self.players = players
        
        }
        
    }
    
    @objc
    private func changePlayer() {
        
        if (players.allSatisfy({($0.hasPlayedRound == true)})) {
            
            for player in players {
                
                player.hasPlayedRound = false
                
            }
            
            endRound()
            
        }
        
        for player in players {
            
            print("player \(players.firstIndex(of: player)! + 1), isCurrent = \(player.isCurrentPlayer), hasPlayed = \(player.hasPlayedRound)")
            
        }
        
        
        guard (currentPlayer == players.first!) else {
            
            currentPlayer = players.first!
            
            return
            
        }
        
        currentPlayer = players.last!
        
        
    }
    
    private func endRound() {
        
        if (gameRound == 3) {
            
            endGame()
            
            return
            
        }
        
        gameRound += 1
        
    }
    
    private func endGame() {
        
        
        
    }
    
    
    private func addObservers() {
        
        notificationCenter.addObserver(self, selector: #selector(changePlayer), name: notification(name: "PlayerHasFinished"), object: nil)
        
    }
    
    private func removeObservers() {
        
       // notificationCenter.remove
        
    }
    
    deinit {
        removeObservers()
    }

}
