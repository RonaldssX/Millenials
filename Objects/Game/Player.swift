//
//  Player.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public final class Player: NSObject {
    
        // autodescritivo
    public init(name: String?, picture: UIImage? = nil, color: UIColor? = nil) {
        
        self.points = 0
        
        self.questions = []
        self.answeredQuestions = []
        
        self.name = name
        self.picture = picture
        self.color = color
        
        self.answeredQuestions = []
        
    }
        // nome do jogador
    public var name: String?
    
        // foto do jogador (caso tenha)
    public var picture: UIImage?
    
        // cor do jogador (caso use a foto padrão)
    public var color: UIColor?
    
        // autodescritivo
    public var hasPlayedRound: Bool = false
    
        // autodescritivo
    public var points: Int
    
    /*
     // multiplicador da pontuação do
     // jogador. valor padrão == 1,
     // muda para == 2 quando o jogador
     // acerta 3 ou mais questões seguidas
     // no mesmo round.
    */
    public var multiplier: Int {
        
        get {
            
            guard (questions.count <= 2) else { return 1 }
            
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
    public var questions: [Question] {
        
        didSet {
            
            guard (self.questions.count != 0) else { return }
            
            self.questions = self.questions.shuffled()            
            
        }
        
    }
    
    public var currentQuestion: Question?
    
        // autodescritivo
    public var answeredQuestions: [AnsweredQuestion]
    
    /*
     // função usada pra controlar o flow das
     // questões. nome autodescritivo.
    */
    public func refreshCurrentQuestion() {
        
        guard (questions.count != 0) else { return }
        
        currentQuestion = questions.first
        
    }
    
    public func questionAnswered(answer: String? = nil) {
        
        guard (questions.count != 0) else { return }
        
        let answeredQuestion = currentQuestion?.answered(answer, multiplier: multiplier)
        
        answeredQuestions.append(answeredQuestion!)
        
        _ = questions.removeFirst()
        
        if (answeredQuestion!.answeredCorrectly) { addPoints() }
        
    }
    
        // autodescritivo
    deinit {
        
        name = nil
        picture = nil
        color = nil
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
}

extension Player {
    
    // autodescritivo
    private func addPoints() {
        
        guard let lastAnsweredQuestion = answeredQuestions.last else { return }
        
        points += lastAnsweredQuestion.value * multiplier
        
        
    }
    
}
