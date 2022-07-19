//
//  Millenials.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

var _currentPlayer: Player? { get { return Millenials.shared.currentPlayer } }
var _currentQuestion: Question? { get { return Millenials.shared.currentPlayer?.currentQuestion } }

fileprivate let maxRounds: Int = 3

protocol MillenialsProtocol {
    var players: [Player] { get set }
    var gameRound: Int { get set }
    
}

protocol MillenialsGameProtocol {
    func startGame()
    func startRoumd()
    func earlyEndGame()
    func endGame()
}

class Millenials {
    
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
            
            self.currentPlayer?.refreshCurrentQuestion()
            WatchHandler.shared.sendUpdates()
            
        }
        
    }
    
    var gameRound: Int {
        
        didSet {
            
            guard (self.gameRound > 0 && self.gameRound <= maxRounds) else { return }
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
        currentPlayer = players.first
        
    }
    
    func playerFinished() {
        
        currentPlayer?.hasPlayedRound = true
        changePlayer()
        
    }
    
    func endRound() {
        guard (players.allSatisfy({ $0.hasPlayedRound })) else { return }
        guard (gameRound != maxRounds) else { return endGame() }
        
        gameRound++
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
        for player in players { player.questions = Questions.shared.roundQuestions.shuffled() }

    }
    
    @objc
    private func changePlayer() {
        
        guard (players.count != 0) else { return }
        currentPlayer = players.first() { $0 != currentPlayer }
        endRound()
        
    }
    
    private func checkResults() -> Player? {
        
        let hasWinner: (Bool, Player?) = {
            guard players.count >= 2 else { return (false, nil) }
            
            if (players[0].points == players[1].points) { return (false, nil) }
            
            let winningPlayer = players.sorted() { $0.points > $1.points }[0]
            return (true, winningPlayer)
            
        }()
        return hasWinner.1
    }    
}

