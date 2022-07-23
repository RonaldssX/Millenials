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

protocol MillenialsDataProtocol {
    func receivePlayers(_ players: [Player])
}

protocol MillenialsInteractionsProtocol: AnyObject {
    
    func questionHasBeenAnswered(_ question: Question, answer: String, order: [String], time: Int)
    func questionHasNotBeenAnswered(_ question: Question, order: [String])
    
}


private protocol MillenialsGameFlowProtocol {
    func startGame()
    func startRound()
    func endRound()
    func endGame()
}

// MARK: - MillenialsDataProtocol conforms
class Millenials: MillenialsDataProtocol {
    
    init() {
        self.players = []
        self.gameRound = 0
        self.gameHasEnded = false
    }
    
    static let shared = Millenials()
    
    var endGameResults: MillenialsResults?
    
    var players: [Player]
    var currentPlayer: Player?
    
    var gameRound: Int
    var gameHasEnded: Bool
    
    func receivePlayers(_ players: [Player]) {
        self.players = players
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

// MARK: - MillenialsInteractionsProtocol conforms
extension Millenials: MillenialsInteractionsProtocol {
    
    func questionHasBeenAnswered(_ question: Question, answer: String, order: [String], time: Int) {
        let answeredQuestion = answeredQuestion(question, player: currentPlayer!, answer: answer, order: order, time: time)
        currentPlayer?.playerDidAnswer(question: answeredQuestion)
    }
    
    func questionHasNotBeenAnswered(_ question: Question, order: [String]) {
        let unansweredQuestion = answeredQuestion(question, player: currentPlayer!, answer: nil, order: order, time: GameConfigs.shared.millenialsConfig.timerDuration)
        currentPlayer?.playerDidNotAnswer(question: unansweredQuestion)
    }
    
    func playerFinished() {
        currentPlayer?.playerFinishedPlayingCurrentRound(gameRound)
        changePlayer()
    }
    
    private func answeredQuestion(_ question: Question, player: Player, answer: String?, order: [String], time: Int) -> AnsweredQuestion {
        let answeredQuestionExtraData: [String: Any] = ["id": question.id, "order": order, "time": time]
        let answeredQuestion = question.answered(answer, player: player, additionalData: answeredQuestionExtraData)
        return answeredQuestion
    }
    
}

// MARK: - MillenialsGameFlowProtocol conforms
extension Millenials: MillenialsGameFlowProtocol {
 
    func startGame() {
        gameHasEnded = false
        if (GameConfigs.millenialsConfig.shouldShufflePlayers) {
            for _ in 1...10 { players = players.shuffled() }
        }
        currentPlayer = players.first
        startRound()
    }
    
    func startRound() {
        if (gameRound >= GameConfigs.millenialsConfig.numberOfRounds) { return endGame() }
        gameRound++
        refreshQuestions()
    }
    
    func endRound() {
        guard (players.allSatisfy({ $0.hasPlayedRound })) else { return }
        players.forEach { player in player.hasPlayedRound = false }
        startRound()
    }
    
    func endGame() {
        gameHasEnded = true
        self.endGameResults = MillenialsResults(winner: nil)
    }
    
    private func refreshQuestions() {
        let questions = Questions.shared.newQuestions(round: gameRound)
        for player in players { player.playerReceivedRoundQuestions(questions.shuffled()) }
    }
    
    private func changePlayer() {
        guard (players.count != 0) else { return }
        // removemos o atual jogador
        // e colocamos ele de volta no final da lista
        let lastPlayer = players.removeFirst()
        players.append(lastPlayer)
        // pegamos o primeiro jogador da lista
        let player = players.first!
        // se ele já jogou esse round, todos já jogaram
        if (player.hasPlayedRound) {
            endRound()
        }
        currentPlayer = player
    }
    
}

struct Round {
    
    var players: [Player] = []
    var questions: [Question] = []
    var answers: [Player: AnsweredQuestion] = [:]
    
}
