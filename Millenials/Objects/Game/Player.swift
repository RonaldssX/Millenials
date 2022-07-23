//
//  Player.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerProtocol {
    var name: String { get }
    var picture: UIImage { get }
    var color: UIColor { get }
    
}

protocol PlayerDelegateProtocol {
    
    func playerReceivedRoundQuestions(_ questions: [Question])
    func playerStartedPlayingCurrentRound(_ round: Int)
    func playerDidNotAnswer(question: AnsweredQuestion)
    func playerDidAnswer(question: AnsweredQuestion)
    func playerFinishedPlayingCurrentRound(_ round: Int)
    
}

final class Player: PlayerProtocol {
    
        // autodescritivo
    init(name: String, picture: UIImage, color: UIColor) {
        
        self.name = name
        self.picture = picture
        self.color = color
        self.roundsPlayed = []
        self.hasPlayedRound = false
        self.isCurrentPlayer = false
        self.points = 0
        self.answeredQuestionsStore = {
            var ret: [[AnsweredQuestion]] = []
            while (ret.count != GameConfigs.shared.millenialsConfig.numberOfRounds) {
                ret.append([])
            }
            return ret
        }()
        self.questions = []
        
    }
        // nome do jogador
    var name: String
    
        // foto do jogador (caso tenha)
    var picture: UIImage
    
        // cor do jogador (caso use a foto padrão)
    var color: UIColor
    
        // autodescritivos
    var roundsPlayed: [Int]
    var hasPlayedRound: Bool
    var isCurrentPlayer: Bool
    
        // autodescritivo
    var points: Int
    
    /*
     // multiplicador da pontuação do
     // jogador. valor padrão == 1,
     // muda para == 2 quando o jogador
     // acerta 3 ou mais questões seguidas
     // no mesmo round.
    */
    var multiplier: Int {
        get {
            if (currentQuestionIndex >= 3) {
                let currentRound = Millenials.shared.gameRound
                var answers: [AnsweredQuestion] = answeredQuestionsStore[currentRound - 1] // todas do round
                answers = Array(answers[...2]) // 3 mais recentes
                if (answers.allSatisfy { $0.answeredCorrectly }) {
                    return 2
                }
            }
            return 1
        }
    }
    
    var answeredQuestionsStore: [[AnsweredQuestion]]
    
    /*
     // Array contendo as questões que o jogador vai responder
     // vai responder no round. atribuído pelo Millenials.
     //
    */
    var questions: [Question] {
        didSet {
            currentQuestionIndex = 0
        }
    }
    
    private var currentQuestionIndex: Int = 0
    var currentQuestion: Question {
        get {
            if (currentQuestionIndex < questions.count) {
                return questions[currentQuestionIndex]
            }
            return questions.first.unsafelyUnwrapped
        }
    }
    
        // autodescritivo
    var answeredQuestions: [AnsweredQuestion] {
        get {
            return answeredQuestionsStore.flatMap() { $0 }
        }
    }
    
}

// MARK: - Equatable and Hashable conforms
extension Player: Equatable, Hashable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
    
    static func != (lhs: Player, rhs: Player) -> Bool {
        return !(lhs == rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        for property in [name as AnyHashable, color as AnyHashable
        ] { hasher.combine(property) }
    }
    
}

// MARK: - PlayerDelegateProtocol conforms
extension Player: PlayerDelegateProtocol {
    
    func playerReceivedRoundQuestions(_ questions: [Question]) {
        self.questions = questions
    }
    
    func playerStartedPlayingCurrentRound(_ round: Int) {
        isCurrentPlayer = true
        currentQuestionIndex = 0
    }
    
    func playerDidNotAnswer(question: AnsweredQuestion) {
        addQuestionToStore(question)
        currentQuestionIndex++
    }
    
    func playerDidAnswer(question: AnsweredQuestion) {
        addQuestionToStore(question)
        currentQuestionIndex++
        addPoints(points: question.pointsEarned)
    }
    
    func playerFinishedPlayingCurrentRound(_ round: Int) {
        isCurrentPlayer = false
        hasPlayedRound = true
        roundsPlayed.append(round)
    }
    
    @discardableResult
    private func addPoints(points: Int) -> Int {
        self.points += points
        return self.points
    }
    
    private func addQuestionToStore(_ quest: AnsweredQuestion) {
        if let question = quest.question {
            // ja sabemos aonde colocar ela
            answeredQuestionsStore[question.level.rawValue].append(quest)
        } else {
            // vamos descobrir qual eh a question via id guardado
            let id: Int = quest.extraData["id"] as! Int
            if let question = Questions.shared.question(withID: id) {
                answeredQuestionsStore[question.level.rawValue].append(quest)
            }
        }
    }
    
}
