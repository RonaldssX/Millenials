//
//  Questions.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
/*
protocol QuestionProtocol: AnyObject, Hashable {
    
    var level: QuestionLevel { get }
    var value: Int { get }
    var statement: String { get }
    var answers: [String] { get }
    var correctAnswer: String { get }
    
    var answeredStore: AnsweredQuestionProtocol? { get set }
    
    func answered(_ playerAnswer: String?, multiplier: Int) -> AnsweredQuestionProtocol
    
}

extension QuestionProtocol {
    
    static func == (lhs: Self, rhs: Self) -> Bool { return lhs.statement == rhs.statement }
    func hash(into hasher: inout Hasher) { for property in [statement as AnyHashable, answers as AnyHashable] {hasher.combine(property)} }
    
}
 
*/
enum QuestionLevel: Int, CaseIterable, Codable {
    
    case Easy = 0
    case Medium = 1
    case Hard = 2
    
    init(id: Int) {
        switch id {
        case 1: self = .Easy
        case 2: self = .Medium
        case 3: self = .Hard
        default: self = .Easy
        }
    }
    
}
final class Question: Decodable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case level, statement, correctAnswer
        case answers = "options"
    }
    
    /*
     // nível de dificuldade
     // da questão. var usada
     // para calcular o valor
     // da questão e para ajudar
     // na seleção de questões
    */
    var level: QuestionLevel
    
    /*
     // valor, sem o multiplier,
     // da questão
    */
    var value: Int {
        get {
            switch level {
            case .Easy: return 100
            case .Medium: return 200
            case .Hard: return 400
            }
        }
    }
    
    /*
     // enunciado da questão
    */
    var statement: String
    
    /*
     // resposta certa da questão,
     // separada de todas as respostas
    */
    var correctAnswer: String
    
    /*
     // todas as respostas, incluindo a
     // resposta certa (que fica sempre
     // no index 0)
    */
    var answers: [String]
    
    var answeredStore: AnsweredQuestion?
    
    init(level: QuestionLevel, statement: String, answers: [String], correctAnswer: String) {
        self.level = level
        self.statement = statement
        self.correctAnswer = correctAnswer
        self.answers = answers
    }
    
    func answered(_ playerAnswer: String?, multiplier: Int, additionalData: [String: Any]?) -> AnsweredQuestion {
        if let answeredStore = answeredStore { return answeredStore }
        let answer = AnsweredQuestion()
        answer.question = self
        answer.configure(with: playerAnswer, multiplier: 1, additionalData: additionalData)
        self.answeredStore = answer
        return answer
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool { return lhs.statement == rhs.statement }
    func hash(into hasher: inout Hasher) { for property in [statement as AnyHashable, answers as AnyHashable] {hasher.combine(property)} }
    
}
