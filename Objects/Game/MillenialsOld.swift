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
            
            self.currentPlayer = self.players.randomElement()!
            
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
            
        }        
        
    }
    
    private lazy var questions: QuestionMaster! = { return QuestionMaster() }()
    
    
    public var gameRound: Int! {
        
        didSet {
            
            questions.gameRound = self.gameRound
            
            _ = players!.map({(player) -> Player in
                
                player.gameRound = self.gameRound
                player.questionsToAnswer = questions.roundQuestions
                
                return player
                
            })
            
            
            
        }
        
    }
    
    
    lazy private var notificationCenter: NotificationCenter = {
       
        return NotificationCenter.default
        
    }()
    
    
    required init(players: [Player]) {
        
        super.init()
        
        addObservers()
       
        defer {
            
        self.players = players
            
        self.gameRound = 1
        
        }
        
    }
    
    @objc
    private func changePlayer() {
        
        if (players.allSatisfy({($0.hasPlayedRound == true)})) {
            
            _ = players!.map({(player) -> Player in
                
                player.hasPlayedRound = false
                
                return player
                
            })
            
            endRound()
            
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
        
        notificationCenter.post(name: "GameHasEnded")
        
    }
    
    
    private func addObservers() {
        
        notificationCenter.addObserver(self, selector: #selector(changePlayer), name: notification(name: "PlayerHasFinished"), object: nil)
        
    }
    
    private func removeObservers() {
        
        notificationCenter.removeObserver(self)
        
    }
    
    deinit {
        removeObservers()
        questions = nil
        players = nil
        gameRound = nil
        currentPlayer = nil
    }

}
