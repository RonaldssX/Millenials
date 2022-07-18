//
//  Questions.swift
//  Millenials
//
//  Created by Ronaldo Santana on 28/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//


/*
    // Os arrays conterão somente Strings.
    // Estrutura dos arrays de questões:
    // [0] = Pergunta
    // [1] = Resposta certa
    // [2] = Primeira resposta errada
    // [3] = Segunda resposta errada
    // [4] = Terceira resposta errada
 */

/*
 let easy = ["Eu jamais ia estuprar você porque você não merece",
 "Bandido bom, é bandido morto!"]
 
 let medium = ["O erro da ditadura foi torturar e não matar",
 "Foram quatro homens. A quinta eu dei uma fraquejada, e veio uma mulher",
 "Se eu chegar lá, não vai ter dinheiro para ONG. Esses inúteis vão ter que trabalhar"]
 
 let hard = ["Ele devia ir comer um capim ali fora para manter as suas origens",
 "Como eu estava solteiro na época, esse dinheiro do auxílio-moradia eu usava para comer gente",
 "Maioria é uma coisa e minoria é outra, e a minoria tem que se calar e se curvar a maioria. Eu quero respeitar é a maioria."]
 
 */

import Foundation
import UIKit.UIImage


enum QuestionType {
    
    case PhrasePerson
    case PhraseDefine
    
}

fileprivate struct QuestionData {
    
    func randomEasyQuestion() -> String {
        
       return Phrases().easyPhrases.randomElement()!
        
    }
    
    func randomMediumQuestion() -> String {
        
        return Phrases().mediumPhrases.randomElement()!
        
    }
    
    func randomHardQuestion() -> String {
        
       return Phrases().hardPhrases.randomElement()!
        
    }
    
    struct Phrases {
        
        var easyPhrases: [String] {
            
            get {
                
                let easy = Easy()
                
                return easy.bolsonaro + easy.hitler + easy.trump + easy.lula
                
            }
            
        }
        
        var mediumPhrases: [String] {
            
            get {
                
                let med = Medium()
                
                return med.bolsonaro + med.hitler + med.trump + med.lula
                
            }
            
        }
        
        var hardPhrases: [String] {
            
            let hard = Hard()
            
            return hard.lula + hard.mao
            
        }
        
        
        
       private struct Easy {
            
            
            let bolsonaro = ["Eu jamais ia estuprar você porque você não merece",
                                                         "Bandido bom, é bandido morto!",
                                                         "Seria incapaz de amar um filho homossexual. Prefiro que um filho meu morra num acidente do que apareça com um bigodudo por aí"]
            
            let hitler = ["O holocausto é a solução definitiva para os judeus"]
            
            let trump = ["Vou construir um grande muro(...). Marquem minhas palavras"]
            
            let lula = ["Não tem coisa mais fácil do que cuidar de pobre, no Brasil. Com R$ 10, o pobre se contenta"]
            
        }
        
       private struct Medium {
            
            let bolsonaro = [""]
            
            let hitler = ["As massas são femininas e idiotas"]
            
            let trump = ["Eu gosto dos chineses. Eu vendi um apartamento por US$ 15 milhões para alguém da China. Como não gostar deles?",
                                                     "Quando você é uma estrela, te deixam fazer de tudo. Pegar na b*ta. Dá para fazer qualquer coisa",
                                                     "Eu poderia parar no meio da Quinta Avenida e atirar em alguém, e não perderia quaisquer eleitores, ok?"]
            
            let lula = ["Feminismo? Eu acho que é coisa de quem não tem o que fazer"]
            
        }
        
       private struct Hard {
            
            let lula = ["Uma mulher não pode ser submissa ao homem por causa de um prato de comida. Tem que ser submissa porque gosta dele",
                                                    "Quem chega em Windhoek não parece que está em um país africano. Poucas cidades do mundo são tão limpas, tão bonitas arquitetonicamente e tem um povo tão extraordinário como tem essa cidade"]
            let mao = ["O poder político nasce do cano da espingarda"]
            
            
        }
        
    }
    
    
}


fileprivate var easyOptions: [[String]] {
    
    get {
        
        let bolsonaro1 = ["Donald Trump",
                          "Chris Brown",
                          "Cristiano Ronaldo",
                          "Kevin Spacey",
                          "Marco Feliciano",
                          "Johny Depp",
                          "Michael Jackson",
                          "Bill Cosby",
                          "João de Deus"]
        
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
        
        return [bolsonaro1,
                bolsonaro2,
                bolsonaro3,
                hitler1,
                trump1,
                lula1]
        
    }
    
}

fileprivate var mediumOptions: [[String]] {
    
    get {
        
        let bolsonaro1 = ["", "", "", "", ""]
        
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
        
        return [bolsonaro1,
                hitler1,
                trump1,
                trump2,
                trump3,
                lula1]
        
    }
    
}

fileprivate var hardOptions: [[String]] {
    
    get {
        
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
        
        return [lula1,
                lula2,
                mao1]
        
    }
    
}


fileprivate func answersToQuestions(question: String, level: Int) -> [String] {
    
    var questions: [String] = []
    var answers: [String] = []
    var options: [String] = []
    
    if (level == 1) {
      
        questions = QuestionData.Phrases().easyPhrases
        
        let index = questions.firstIndex(of: question)!
        
        options = easyOptions[index]
        
        if (0...2 ~= index) {
            
            answers.append("Jair Bolsonaro")
            
        }
        
        if (3...3 ~= index) {
            
            answers.append("Adolf Hitler")
            
        }
        
        if (4...4 ~= index) {
            
            answers.append("Donald Trump")
            
        }
        
        if (5...5 ~= index) {
            
            answers.append("Lula")
            
        }
        
    }
    
    if (level == 2) {
        
        questions = QuestionData.Phrases().mediumPhrases
        
        let index = questions.firstIndex(of: question)!
        
        options = mediumOptions[index]
        
        if (0...0 ~= index) {
            
            answers.append("Lula")
            
        }
        
        if (1...1 ~= index) {
            
            answers.append("Adolf Hitler")
            
        }
        
        if (2...4 ~= index) {
            
            answers.append("Donald Trump")
            
        }
        
        if (5...5 ~= index) {
            
            answers.append("Lula")
            
        }
        
    }
    
    if (level == 3) {
        
        questions = QuestionData.Phrases().hardPhrases
        
        let index = questions.firstIndex(of: question)!
        
        options = hardOptions[index]
        
        if (0...1 ~= index) {
            
            answers.append("Lula")
            
        }
        
        if (2...2 ~= index) {
            
            answers.append("Mao Tsé-Tung")
            
        }
        
    }
    
    while answers.count != 4 {
        
        let answer = options.randomElement()!
        
        answers.append(answer)
        
        options.remove(at: options.firstIndex(of: answer)!)
        
    }
    
    
    return answers
    
}

class QuestionMaster: NSObject {
    
    public var roundQuestions: [Question]! {
        
        didSet {
            
            self.roundQuestions = self.roundQuestions.shuffled()
            
        }
        
    }
    
    public var gameRound: Int! {
        
        didSet {
            
            nextQuestions()
            
        }
        
    }
    
    private func nextQuestions() {
        
        func newQuestion() -> Question {
            
            let question = Question()
            
            let questionData = QuestionData()
            
            let questionLevels = [questionData.randomEasyQuestion(),
                                  questionData.randomMediumQuestion(),
                                  questionData.randomHardQuestion()]
            
            question.question = questionLevels[gameRound - 1]
            
            
            var questionOptions = answersToQuestions(question: question.question, level: gameRound)
            
            
            question.rightAnswer = questionOptions.removeFirst()
            question.wrongAnswers = questionOptions
            
            return question
        }
       
        roundQuestions = []
       
        while roundQuestions.count != 5 {
            
            let question = newQuestion()
            
            if (roundQuestions.contains(where: {($0.question == question.question)})) {
                
                continue
                
            }
            
            roundQuestions.append(question)
            
        }
    }
    
    
}

final class Question {
    
    public var questionType: QuestionType?
    
    public var questionImage: UIImage?
    
    public var question: String!
    
    public var rightAnswer: String!
    public var wrongAnswers: [String]!
    
}

extension Question: Hashable {
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        
        return lhs.questionType == rhs.questionType && lhs.questionImage == rhs.questionImage && lhs.question == rhs.question
        
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(question)
        
    }
}

