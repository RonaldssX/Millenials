//
//  Millenials.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public var _currentPlayer: Player? { get { return Millenials.shared.currentPlayer } }
public var _currentQuestion: Question? { get { return Millenials.shared.currentPlayer?.currentQuestion } }

fileprivate let maxRounds: Int = 3

public class Millenials {
    
    init() {
        
        self.gameRound = 0
        self.players = []
        
    }
    
    static let shared = Millenials()
    
    var endGameResults: MillenialsResults?
    
    var players: [Player] {
        
        willSet {
            
            guard (newValue.count == 0) else { return }
            currentPlayer = nil 
            
        }
        
    }
    
    var currentPlayer: Player? {
        
        willSet {
            
            guard (players.count != 0),
                  (self.currentPlayer != players.last) else { return }
            
            self.currentPlayer?.hasPlayedRound = true
            
        }
        
        didSet {
            
            guard (self.currentPlayer != nil) else { return }
            
            self.currentPlayer!.refreshCurrentQuestion()
            
        }
        
    }
    
    var gameRound: Int {
        
        didSet {
            
            guard (self.gameRound > 0 && self.gameRound <= maxRounds),
                  (players.count != 0) else { return }
            
            for player in players { player.hasPlayedRound = false }
            
        }
        
    }
    
    var gameHasEnded: Bool = false
    
    func startGame() {
        
        gameRound = 1
        
        gameHasEnded = false
        
        refreshQuestions()
        
        guard (players.count != 0) else { return }
        
        for _ in 1...10 { players = players.shuffled() }
        
        currentPlayer = players[0]
        
    }
    
    func playerFinished() {
        
        currentPlayer?.hasPlayedRound = true
        
        changePlayer()
        
    }
    
    func endRound() {
        
        guard (gameRound != maxRounds) else { return endGame() }
        
        gameRound += 1
        
        guard (players.count != 0) else { return }
        
        for player in players { player.hasPlayedRound = false }
        
        refreshQuestions()
        
    }
    
    func earlyEndGame() {
        
        players = []
        currentPlayer = nil
        gameRound = 0
        gameHasEnded = false
        
        Questions.shared.resetQuestions()
        
    }
    
    func endGame() {
        
        gameHasEnded = true
        
        self.endGameResults = MillenialsResults(winner: checkResults())
        
    }
    
    func prepareForNextGame() {
        
        endGameResults = nil
        players.removeAll()
        currentPlayer = nil
        gameRound = 0
        gameHasEnded = false
        
        Questions.shared.resetQuestions()
        
    }

}

extension Millenials {
    
    private func refreshQuestions() {
        
        Questions.shared.newQuestions(round: gameRound)
        
        guard (players.count != 0) else { return }
        
        for player in players { player.questions = Questions.shared.roundQuestions }
        
    }
    
    @objc
    private func changePlayer() {
        
        guard (players.count != 0) else { return }
        guard (currentPlayer == players.last) else { return currentPlayer = players.last }
        
        endRound()
        
        currentPlayer = players.first
        
    }
    
    private func checkResults() -> Player? {
        
        func hasWinner() -> (Bool, Player?) {
            
            let player1 = players[0]
            let player2 = players[1]
            
            var winningPlayer: Player?
            
            if (player1.points == player2.points) { return (false, nil) }
            
            if (player1.points > player2.points) {
                
                winningPlayer = player1
                
            } else {
                
                winningPlayer = player2
                
            }
            
            return (true, winningPlayer)
            
        }
        
        let results = hasWinner()
        
        if (results.0) {
            
            return results.1
            
        } else { return nil }
        
    }    
    
}
