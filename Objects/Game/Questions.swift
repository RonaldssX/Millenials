//
//  Questions.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public enum QuestionLevel: CaseIterable {
    
    case Easy
    case Medium
    case Hard
    
    init?(id: Int) {
        
        switch id {
            
        case 1: self = .Easy
        case 2: self = .Medium
        case 3: self = .Hard
            
        default: return nil
            
        }
        
    }
    
}

final public class Questions: NSObject {
    
    static let shared = Questions()
    
    public var roundQuestions: [Question] = []
    
    @objc
    public func newQuestions(round: Int) {
        
        if (roundQuestions.count != 0) { roundQuestions.removeAll() }
      
        while (roundQuestions.count != 5) {
            
            let newQuestion = question(level: round)
            
            if (roundQuestions.count >= 1 && roundQuestions.count != 4),
               (roundQuestions[roundQuestions.endIndex - 1].correctAnswer == newQuestion.correctAnswer) { continue }
            
            guard (!roundQuestions.contains(newQuestion)) else { continue }
            
            roundQuestions.append(newQuestion)
            
            
        }
        
    }
    
    public func resetQuestions() {
        
        self.roundQuestions.removeAll()
        
    }

}


public class Question {
    
    /*
     // nível de dificuldade
     // da questão. var usada
     // para calcular o valor
     // da questão e para ajudar
     // na seleção de questões
    */
    public var level: QuestionLevel?
    
    /*
     // valor, sem o multiplier,
     // da questão
    */
    public lazy var value: Int = {
            
           guard (level != nil) else { return 0 }
            
           switch level! {
                
           case .Easy:
               return 100
                
           case .Medium:
               return 200
                
           case .Hard:
               return 400
                
           }
        
    }()
    
    /*
     // enunciado da questão
    */
    public var statement: String?
    
    /*
     // resposta certa da questão,
     // separada de todas as respostas
    */
    public var correctAnswer: String?
    
    /*
     // respostas ERRADAS
    */
    public var wrongAnswers: [String] = []
    
    /*
     // todas as respostas, incluindo a
     // resposta certa (que fica sempre
     // no index 0)
    */
    public var answers: [String]? {
        
        get {
            
            var array: [String] = []
            
            array.append(correctAnswer!)
            array.append(contentsOf: wrongAnswers)
            
            return array
            
        }
        
    }
    
    /*
     // função chamada quando a
     // questão é respondida,
     // criando o objeto usado
     // para guardar as informações
     // da questão
     */
    public func answered(_ answer: String? = nil, multiplier: Int) -> AnsweredQuestion {
        
        return AnsweredQuestion(level: level, statement: statement, correctAnswer: correctAnswer, wrongAnswers: wrongAnswers, playerAnswer: answer, multiplier: multiplier)
        
    }
    
    
    deinit {
        
        level = nil
        statement = nil
        correctAnswer = nil
        wrongAnswers.removeAll()
        
    }
    
}


extension Question: Hashable {
    
    static public func == (lhs: Question, rhs: Question) -> Bool { return lhs.statement == rhs.statement }
    
    static public func == (lhs: Question, rhs: AnsweredQuestion) -> Bool { return lhs.statement == rhs.statement }
    
    static public func == (lhs: AnsweredQuestion, rhs: Question) -> Bool { return lhs.statement == rhs.statement }
    
    public func hash(into hasher: inout Hasher) { for property in [statement as AnyHashable, answers as AnyHashable] {hasher.combine(property)} }
    
}

final public class AnsweredQuestion: Question {
    
    /*
     // a resposta dada pelo jogador
    */
    public var playerAnswer: String? = nil
    
    /*
     // valor que indica se o jogador
     // respondeu a questão
    */
    public var hasAnswered: Bool {
        
        get { return playerAnswer != nil }
        
    }
    
    /*
     // valor que indica se o jogador
     // respondeu a questão corretamente
    */
    public var answeredCorrectly: Bool {
        
        get { return playerAnswer == correctAnswer }
        
    }
    
    private var multiplier: Int
    
    public var pointsEarned: Int {
        
        get { return value * multiplier }
        
    }
    /*
     // inicializador da class para
     // ser usado (somente) pela
     // superclass
    */
    
    fileprivate init(level: QuestionLevel?, statement: String?, correctAnswer: String?, wrongAnswers: [String], playerAnswer: String?, multiplier: Int) {
        
        self.multiplier = multiplier
        
        super.init()
        
        self.level = level
        self.statement = statement
        self.correctAnswer = correctAnswer
        self.wrongAnswers = wrongAnswers
        
        if (playerAnswer != nil) { self.playerAnswer = playerAnswer }
        
    }
    
    deinit {
        
        level = nil
        
        statement = nil
        correctAnswer = nil
        wrongAnswers.removeAll()
        
        playerAnswer = nil
        
    }
    
    
}
