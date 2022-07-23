//
//  Questions.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

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
        case id, level, statement, correctAnswer
        case answersStore = "options"
    }
    /*
        // identificador unico para a questao
     */
    var id: Int
    
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
            case .Easy: return GameConfigs.questionsConfig.easyValue
            case .Medium: return GameConfigs.questionsConfig.mediumValue
            case .Hard: return GameConfigs.questionsConfig.hardValue
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
     // todas as opções de resposta
    */
    private var answersStore: [String] = []
    var answers: [String] {
        get {
            return ([correctAnswer] + answersStore)
        }
        set {
            answersStore = newValue
        }
    }
    
    init(level: QuestionLevel, statement: String, answers: [String], correctAnswer: String) {
        self.id = -1
        self.level = level
        self.statement = statement
        self.correctAnswer = correctAnswer
        self.answers = answers
    }
    
    func answered(_ playerAnswer: String?, player: Player, additionalData: [String: Any]?) -> AnsweredQuestion {
        let answer = AnsweredQuestion()
        answer.question = self
        answer.player = player
        answer.configure(with: playerAnswer, multiplier: player.multiplier, additionalData: additionalData)
        answer.extraData["id"] = self.id
        return answer
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool { return lhs.statement == rhs.statement }
    func hash(into hasher: inout Hasher) { for property in [statement as AnyHashable, answers as AnyHashable] {hasher.combine(property)} }
    
}
