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
    var color: UIColor? { get }
    var points: Int { get }
    
}

final class Player {
    
        // autodescritivo
    init(name: String?, picture: UIImage? = nil, color: UIColor? = nil) {
        
        self.points = 0
        
        self.questions = []
        self.answeredQuestions = []
        
        self.name = name
        self.picture = picture
        self.color = color
        
        self.answeredQuestions = []
        
    }
        // nome do jogador
    var name: String?
    
        // foto do jogador (caso tenha)
    var picture: UIImage?
    
        // cor do jogador (caso use a foto padrão)
    var color: UIColor?
    
        // autodescritivo
    var hasPlayedRound: Bool = false
    
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
            
            guard (questions.count <= 2), answeredQuestions.count > 3 else { return 1 }
            let answeredQuestionsCount = answeredQuestions.count
            let range: Range<Int> = Range((answeredQuestionsCount - 3)...(answeredQuestionsCount - 1))
            guard (answeredQuestions.allSatisfy(in: range, {$0.answeredCorrectly})) else { return 1 }
            return 2
            
        }
        
    }
    
    /*
     // Array contendo as questões que o jogador vai responder
     // vai responder no round. atribuído pelo Millenials.
     // sempre que uma questão é respondida ela é tirada
     // do Array. Quando count == 0, ele finaliza a jogada
     // do jogador.
    */
    var questions: [Question] {
        
        didSet {
            guard (!questions.isEmpty) else { return }
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
    var answeredQuestions: [AnsweredQuestion]
    
    /*
     // função usada pra controlar o flow das
     // questões. nome autodescritivo.
    */
    func refreshCurrentQuestion() {
        
    }
    
    func questionAnswered(answer: String? = nil, order: [String]) {
        
        guard (questions.count != 0) else { return }
        let answeredQuestion = currentQuestion.answered(answer, multiplier: multiplier, additionalData: ["order": order])
        if (answeredQuestion.answeredCorrectly) { addPoints() }
        
    }
    
    @objc
    func answerAllQuestions() {
        guard MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.infiniteQuestions) else { return }
        while let quest = questions.first {
            self.questionAnswered(answer: quest.correctAnswer, order: quest.answers)
            print("answered!!")
        }
    }
    
        // autodescritivo
    deinit {
        
        name = nil
        picture = nil
        color = nil
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
}

extension Player: Equatable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
    
    static func != (lhs: Player, rhs: Player) -> Bool {
        return !(lhs == rhs)
    }
    
}

extension Player {
    
    // autodescritivo
    private func addPoints() {
        if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.noPoints) { return }
        guard let lastAnsweredQuestion = answeredQuestions.last else { return }
        points += lastAnsweredQuestion.pointsEarned
    }
    
}
