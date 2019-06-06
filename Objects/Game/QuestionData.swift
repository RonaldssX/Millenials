//
//  QuestionHolder.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 07/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation

fileprivate struct QuestionParser {
    
    static let shared = QuestionParser()
    
    struct Statements {
        
        static let shared = Statements()
        
        func statementArray(for level: QuestionLevel) -> [String] {
            
            let questionLevelIndex = QuestionLevel.allCases.firstIndex(of: level)!
            
            return allStatementArrays[questionLevelIndex]
            
        }
        
        func level(for array: [String]) -> QuestionLevel {
            
            let statementArrayIndex = allStatementArrays.firstIndex(of: array)!
            
            return QuestionLevel.allCases[statementArrayIndex]
            
        }
        
        var allStatementArrays: Array<[String]> { return [easy, medium, hard] }
        
        var allStatementStrings: [String] {
                
                var allStatementStringsArray: [String] = []
                
                for statementArray in allStatementArrays {
                    
                    statementArray.forEach({allStatementStringsArray.append($0)})
                    
                }
                
                return allStatementStringsArray
            
        }
        
        
        let easy = ["Eu jamais ia estuprar você porque você não merece",
                    "Bandido bom, é bandido morto!",        /* bolsonaro */
                    "Seria incapaz de amar um filho homossexual. Prefiro que um filho meu morra num acidente do que apareça com um bigodudo por aí",
                    
                    "O holocausto é a solução definitiva para os judeus", /* hitler */
                    
                    "Vou construir um grande muro(...). Marquem minhas palavras", /* trump */
            
                    "Não tem coisa mais fácil do que cuidar de pobre, no Brasil. Com R$ 10, o pobre se contenta" /* lula */]
        
        let medium = ["Eu fui num quilombola(...). O afrodescendente mais leve lá pesava sete arrobas. Não fazem nada. Eu acho que nem pra procriadores servem mais",   /* bolsonaro */
                      
                      "As massas são femininas e idiotas", /* hitler */
                      
                      "Eu gosto dos chineses. Eu vendi um apartamento por US$ 15 milhões para alguém da China. Como não gostar deles?",
                      "Quando você é uma estrela, te deixam fazer de tudo. Pegar na b*ta. Dá para fazer qualquer coisa", /* trump */
                      "Eu poderia parar no meio da Quinta Avenida e atirar em alguém, e não perderia quaisquer eleitores, ok?",
        
                      "Feminismo? Eu acho que é coisa de quem não tem o que fazer" /* lula */]
        
        let hard = ["Só não te estupro porque você não merece", /* bolsonaro */
                    
                    "Uma mulher não pode ser submissa ao homem por causa de um prato de comida. Tem que ser submissa porque gosta dele", /* lula */
                    "Quem chega em Windhoek não parece que está em um país africano. Poucas cidades do mundo são tão limpas, tão bonitas arquitetonicamente e tem um povo tão extraordinário como tem essa cidade",
        
                    "O poder político nasce do cano da espingarda", /* mao */
        
                    "Ninguém mais é capaz de indicar os desajustes de preços no supermercado do que a mulher", /* temer */
        
                    "Se você não tem fama de pegador e é solteiro, fica com fama de veado. Então, antes pegador que veado, né?" /* caio castro */ ]
        
    }
    
    struct CorrectAnswers {
        
        static let shared = CorrectAnswers()
        
        func correctAnswerArray(for level: QuestionLevel) -> [String] {
            
            let questionLevelIndex = QuestionLevel.allCases.firstIndex(of: level)!
            
            return allCorrectAnswerArrays[questionLevelIndex]
            
        }
        
        func level(for answersArray: [String]) -> QuestionLevel {
            
            let answerArrayIndex = allCorrectAnswerArrays.firstIndex(of: answersArray)!
            
            return QuestionLevel.allCases[answerArrayIndex]
            
        }
        
        var allCorrectAnswerArrays: Array<[String]> { return [easy, medium, hard] }
        
        let easy = ["Jair Bolsonaro",
                    "Adolf Hitler",
                    "Donald Trump",
                    "Lula"]
        
        let medium = ["Jair Bolsonaro",
                      "Adolf Hitler",
                      "Donald Trump",
                      "Lula"]
        
        let hard = ["Jair Bolsonaro",
                    "Lula",
                    "Mao Tsé-Tung",
                    "Michel Temer",
                    "Caio Castro",
                    "Joelma"]
        
    }
    
    struct WrongAnswers {
        
        static let shared = WrongAnswers()
        
        func wrongAnswersFor(level: QuestionLevel) -> Array<[String]> {
            
            let questionLevelIndex = QuestionLevel.allCases.firstIndex(of: level)!
            
            return allWrongAnswersArrays[questionLevelIndex]
            
        }
        
        var allWrongAnswersArrays: Array<Array<[String]>> { return [easy, medium, hard] }
        
        var easy: Array<[String]> {
                
                let bolsonaro1 = ["Donald Trump",
                                  "Chris Brown",
                                  "Cristiano Ronaldo",
                                  "Kevin Spacey",
                                  "Marco Feliciano",
                                  "Johny Depp",
                                  "Michael Jackson",
                                  "Bill Cosby",
                                  "João de Deus",
                                  "Neymar Jr."]
                
                let bolsonaro2 = ["Donald Trump",
                                  "Cabo Daciolo",
                                  "João Amoêdo",
                                  "Getúlio Vargas",
                                  "João Goulart",
                                  "Jânio Quadros",
                                  "Castelo Branco",
                                  "Nicolás Maduro",
                                  "Kim Jong-un",
                                  "Vladimir Putin",
                                  "Bashar al-Assad"]
                
                let bolsonaro3 = ["Ciro Gomes",
                                  "Geraldo Alckmin",
                                  "José Serra",
                                  "Vladimir Putin",
                                  "Bashar al-Assad",
                                  "Hugo Chávez",
                                  "Anthony Garotinho",
                                  "Fernando Henrique Cardoso",
                                  "Barack Obama"]
                
                let hitler1 = ["Winston Churchill",
                               "Josef Stalin",
                               "Joseph Goebbels",
                               "Abraham Lincoln",
                               "Napoleão Bonaparte",
                               "Adolf Eichmann",
                               "Paula Hitler",
                               "Mao Tsé-Tung"]
                
                let trump1 = ["Josef Stalin",
                              "Itamar Franco",
                              "Castelo Branco",
                              "Adolf Hitler",
                              "Nicolás Maduro",
                              "Napoleão Bonaparte",
                              "Angela Merkel",
                              "Kim Jong-un",
                              "Hillary Clinton",
                              "Emmanuel Macron",
                              "Marine Le Pen",
                              "Justin Trudeau"]
                
                let lula1 = ["Jair Bolsonaro",
                             "Michel Temer",
                             "Castelo Branco",
                             "João Amôedo",
                             "Jânio Quadros",
                             "Juscelino Kubitschek",
                             "Getúlio Vargas",
                             "Júlio Prestes",
                             "Dilma Rousseff",
                             "Fernando Haddad",
                             "Guilherme Boulos",
                             "João Goulart"]
                
                return [bolsonaro1, bolsonaro2, bolsonaro3, hitler1, trump1, lula1]
            
        }
        
        var medium: Array<[String]> {
                
                let bolsonaro1 = ["Lula",
                                  "Michel Temer",
                                  "Donald Trump",
                                  "Fernando Haddad",
                                  "Ciro Gomes",
                                  "Aécio Neves"]
                
                let hitler1 = ["Jair Bolsonaro",
                               "Donald Trump",
                               "Theresa May",
                               "Ciro Gomes",
                               "David Cameron",
                               "Margaret Thatcher",
                               "Ronald Reagan",
                               "George H. W. Bush",
                               "João Goulart",
                               "Fernando Henrique Cardoso",
                               "Levy Fidélix",
                               "Geraldo Alckmin"]
                
                let trump1 = ["Geraldo Alckmin",
                              "Henrique Meirelles",
                              "Bill Clinton",
                              "John F. Kennedy",
                              "Ronald Reagan",
                              "George W. Bush",
                              "Bashar al-Assad"]
                
                let trump2 = ["Alexandre Frota",
                              "Johnny Depp",
                              "Leonardo DiCaprio",
                              "Biel",
                              "Silvio Santos",
                              "Bruno Mars",
                              "Pedro Bial",
                              "Chris Brown",
                              "Cristiano Ronaldo",
                              "Charlie Sheen",
                              "Jair Bolsonaro"]
                
                let trump3 = ["Jair Bolsonaro",
                              "Lula",
                              "Fernando Haddad",
                              "George W. Bush",
                              "Cabo Daciolo",
                              "João Amoêdo",
                              "Álvaro Dias",
                              "Aécio Neves",
                              "Ciro Gomes",
                              "Barack Obama",
                              "Ronald Reagan"]
                
                let lula1 = ["Jair Bolsonaro",
                             "Donald Trump",
                             "Hamilton Mourão",
                             "Henrique Meirelles",
                             "George W. Bush",
                             "Geraldo Alckmin",
                             "Vladimir Putin",
                             "Nicolás Maduro",
                             "Fidel Castro",
                             "Raúl Castro",
                             "Adolf Hitler"]
                
                return [bolsonaro1, hitler1, trump1, trump2, trump3, lula1]
            
        }
        
        var hard: Array<[String]> {
            
                let bolsonaro1 = ["Donald Trump",
                                  "Chris Brown",
                                  "Cristiano Ronaldo",
                                  "Kevin Spacey",
                                  "Marco Feliciano",
                                  "Johny Depp",
                                  "Michael Jackson",
                                  "Bill Cosby",
                                  "João de Deus",
                                  "Neymar Jr."]
                
                let lula1 = ["Jair Bolsonaro",
                             "Donald Trump",
                             "Cabo Daciolo",
                             "Henrique Meirelles",
                             "Getúlio Vargas",
                             "Che Guevara"]
                
                let lula2 = ["Donald Trump",
                             "Jair Bolsonaro",
                             "Dilma Rousseff",
                             "Michel Temer",
                             "Fernando Henrique Cardoso",
                             "Fernando Collor",
                             "Itamar Franco",
                             "Barack Obama",
                             "Bill Clinton",
                             "Nicolás Maduro",
                             "Evo Morales",
                             "Vladimir Putin"]
                
                let mao1 = ["Che Guevara",
                            "Joseph Stalin",
                            "Getúlio Vargas",
                            "Hamilton Mourão",
                            "Jair Bolsonaro",
                            "Fidel Castro",
                            "Raúl Castro",
                            "Guilherme Boulos",
                            "Ciro Gomes",
                            "Lula",
                            "Castelo Branco",
                            "João Goulart",
                            "Jânio Quadros"]
                
                let temer1 = ["Donald Trump",
                              "Jair Bolsonaro",
                              "Barack Obama",
                              "Hillary Clinton"]
            
                let caio1 = ["Luan Santana",
                             "Neymar Jr.",
                             "Biel",
                             "Brad Pitt",
                             "Justin Timberlake"]
            
                let joelma1 = ["Fernanda Montenegro",
                               "Giovanna Antonelli",
                               "Glórias Menezes",
                               "Lilia Cabral",
                               "Claudia Raia",
                               "Regina Duarte",
                               "Adriana Esteves"]
                
                return [bolsonaro1, lula1, lula2, mao1, temer1, caio1, joelma1]
            
        }
        
    }
    
    static func randomEasyStatement() ->   String { return Statements.shared.easy.randomElement()! }
    
    static func randomMediumStatement() -> String { return Statements.shared.medium.randomElement()! }
    
    static func randomHardStatement() ->   String { return Statements.shared.hard.randomElement()! }
  
    func correctAnswer(statement: String) -> String {
        
        func discoverLevelAndIndex() -> (QuestionLevel, Int) {
           
            var level: QuestionLevel!
            
            for statementArray in Statements.shared.allStatementArrays {
                
                guard (statementArray.contains(statement)) else { continue }
                
                level = Statements.shared.level(for: statementArray)
                
            }
            
            return (level, Statements.shared.statementArray(for: level).firstIndex(of: statement)!)
            
        }
        
        func getRightAnswer(for level: QuestionLevel, index: Int) -> String {
            
            var answer: String = ""
            
            let correctAnswersArray = CorrectAnswers.shared.correctAnswerArray(for: level)
            
            if (level == .Easy) {
            
                if 0...2 ~= index { answer = correctAnswersArray[0] }
                if 3...3 ~= index { answer = correctAnswersArray[1] }
                if 4...4 ~= index { answer = correctAnswersArray[2] }
                if 5...5 ~= index { answer = correctAnswersArray[3] }
                
            }
            
            if (level == .Medium) {
                
                if 0...0 ~= index { answer = correctAnswersArray[0] }
                if 1...1 ~= index { answer = correctAnswersArray[1] }
                if 2...4 ~= index { answer = correctAnswersArray[2] }
                if 5...5 ~= index { answer = correctAnswersArray[3] }
                
            }
            
            if (level == .Hard) {
                
                if 0...0 ~= index { answer = correctAnswersArray[0] }
                if 1...2 ~= index { answer = correctAnswersArray[1] }
                if 3...3 ~= index { answer = correctAnswersArray[2] }
                if 4...4 ~= index { answer = correctAnswersArray[3] }
                if 5...5 ~= index { answer = correctAnswersArray[4] }
                if 6...6 ~= index { answer = correctAnswersArray[5] }
                
            }
            
                
            return answer
            
        }
        
        let levelAndIndex = discoverLevelAndIndex()
        
        return getRightAnswer(for: levelAndIndex.0, index: levelAndIndex.1)
        
    }
    
    func wrongAnswers(statement: String, level: QuestionLevel) -> [String] {
        
        let wrongAnswersArray = WrongAnswers.shared.wrongAnswersFor(level: level)
        let statementIndex = Statements.shared.statementArray(for: level).firstIndex(of: statement)!
        
        return wrongAnswersArray[statementIndex]
        
    }
    
}

extension Questions {
    
    internal func question(level: QuestionLevel) -> Question {
        
        let questionObject = Question()
        
        let questionParser = QuestionParser.shared
        
            questionObject.level = level
        
        switch level {
            
        case .Easy:
            questionObject.statement = QuestionParser.randomEasyStatement()
            
        case .Medium:
            questionObject.statement = QuestionParser.randomMediumStatement()
        
        case .Hard:
            questionObject.statement = QuestionParser.randomHardStatement()
            
        }
        
            questionObject.correctAnswer = questionParser.correctAnswer(statement: questionObject.statement!)
            questionObject.wrongAnswers = questionParser.wrongAnswers(statement: questionObject.statement!, level: level)
        
        return questionObject
        
    }
    
    func question(level: Int) -> Question {
        
        if (level == 1) { return question(level: .Easy) }
        if (level == 2) { return question(level: .Medium) }
        if (level == 3) { return question(level: .Hard) }
        
        return Question()
        
    }
    
}

