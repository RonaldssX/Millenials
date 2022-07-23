//
//  QuestionHolder.swift
//  Millenials+
//
//  Created by Ronaldo Santana on 18/07/21.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation

final class QuestionHolder: Decodable {
    
    enum CodingKeys: CodingKey {
        case questions
    }
    
    var questions: Set<Question> = [] {
        didSet {
            sortQuestions()
        }
    }
    
    var shouldSortQuestions: Bool = false {
        didSet {
            if (shouldSortQuestions) {
                sortQuestions()
            }
        }
    }
    private var didSortQuestions: Bool = false
    
    var easyQuestions: Set<Question> = []
    var mediumQuestions: Set<Question> = []
    var hardQuestions: Set<Question> = []
    
    func questions(forLevel: QuestionLevel) -> Set<Question> {
        if (!didSortQuestions) {
            sortQuestions()
        }
        switch forLevel {
        case .Easy: return easyQuestions
        case .Medium: return mediumQuestions
        case .Hard: return hardQuestions
        }
    }
    
    func question(withID id: Int) -> Question? {
        return questions.first() { $0.id == id }
    }
    
    func reset() {
        hardQuestions.removeAll()
        mediumQuestions.removeAll()
        easyQuestions.removeAll()
        questions.removeAll()
        shouldSortQuestions = false
        didSortQuestions = false
    }
    
    private func performWhatAPResenterShould() {
        let config = GameConfigs.shared.questionsConfig
        var numberOfAnswers = config.numberOfOptionsPerQuestion
        if (config.includesCorrectOption) {
            numberOfAnswers--
        }
        for question in questions {
            if question.answers.count > numberOfAnswers {
                let newAnswers = Array(question.answers[1...numberOfAnswers])
                question.answers = newAnswers
            }
        }
    }
    
    private func sortQuestions() {
        performWhatAPResenterShould()
        guard !questions.isEmpty else { return }
        questions.forEach { question in
            switch question.level {
            case .Easy: easyQuestions.insert(question)
            case .Medium: mediumQuestions.insert(question)
            case .Hard: hardQuestions.insert(question)
            }
        }
        didSortQuestions = true
    }
    
}

final class Questions {
    
    static let shared = Questions()
    
    private var didLoadQuestions: Bool = false
    
    private var questionHolder: QuestionHolder!
    var roundQuestions: [Question] = []
    
    @discardableResult
    func newQuestions(round: Int) -> [Question] {
        roundQuestions = []
        loadQuestionsIfNeeded()
        let numberOfQuestions = GameConfigs.questionsConfig.numberOfQuestionsPerRound
        let questionLevel = QuestionLevel(id: round)
        var allRoundQuestions = Set(questionHolder.questions(forLevel: questionLevel))
        if (allRoundQuestions.count > numberOfQuestions) {
            while (roundQuestions.count != numberOfQuestions) {
                let rand = allRoundQuestions.randomElement()!
                roundQuestions.append(allRoundQuestions.remove(rand)!)
            }
        } else {
            roundQuestions = allRoundQuestions.shuffled()
        }
        return roundQuestions
    }
    
    func resetQuestions() {
        questionHolder.reset()
        roundQuestions.removeAll()
        didLoadQuestions = false
    }
    
    private func loadQuestionsIfNeeded() {
        if !didLoadQuestions {
            loadQuestions()
        }
    }
    
     private func loadQuestions() {
         let fileName = GameConfigs.questionsConfig.jsonFilename
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            let pathURL = URL(fileURLWithPath: path)
            if let file = try? Data(contentsOf: pathURL),
               let result = try? JSONDecoder().decode(QuestionHolder.self, from: file) {
                questionHolder = result
                didLoadQuestions = true
                return
            }
        }
         questionHolder = QuestionHolderMock.fallbackGetFromMockedJSON()
    }

}

// metodos para achar questoes
extension Questions {
    
    func question(withID id: Int) -> Question? {
        return questionHolder.question(withID: id)
    }
    
    func question(withAnswered quest: AnsweredQuestion) -> Question? {
        if let id = quest.extraData["id"] as? Int {
            return question(withID: id)
        }
        return nil
    }
    
}

// aqui é no pior dos casos. vou deixar um json como string aqui
// para caso o load (ainda local) das questoes falhar a gente puxa
// pra esse.

// se esse também falhar o negócio todo vai crashar parabens ao envolvido
fileprivate final class QuestionHolderMock {
    
    static func fallbackGetFromMockedJSON() -> QuestionHolder {
        let data: Data = jsonString.data(using: .utf8)!
        if let result = try? JSONDecoder().decode(QuestionHolder.self, from: data) {
            return result
        }
        // fodase vou botar pra abortar aqui
        abort()
    }
    
    static private let jsonString: String = """
{
    "questions": [{
            "id": 0,
            "level": 0,
            "statement": "Eu jamais ia estuprar você porque você não merece",
            "options": ["Donald Trump",
                "Chris Brown",
                "Cristiano Ronaldo",
                "Kevin Spacey",
                "Marco Feliciano",
                "Johny Depp",
                "Michael Jackson",
                "Bill Cosby",
                "João de Deus",
                "Neymar Jr."
            ],
            "correctAnswer": "Jair Bolsonaro"
        },
        {
            "id": 1,
            "level": 0,
            "statement": "Bandido bom, é bandido morto!",
            "options": ["Donald Trump",
                "Cabo Daciolo",
                "João Amoêdo",
                "Getúlio Vargas",
                "João Goulart",
                "Jânio Quadros",
                "Castelo Branco",
                "Nicolás Maduro",
                "Kim Jong-un",
                "Vladimir Putin",
                "Bashar al-Assad"
            ],
            "correctAnswer": "Jair Bolsonaro"
        },
        {
            "id": 2,
            "level": 0,
            "statement": "Seria incapaz de amar um filho homossexual. Prefiro que um filho meu morra num acidente do que apareça com um bigodudo por aí",
            "options": ["Ciro Gomes",
                "Geraldo Alckmin",
                "José Serra",
                "Vladimir Putin",
                "Bashar al-Assad",
                "Hugo Chávez",
                "Anthony Garotinho",
                "Fernando Henrique Cardoso",
                "Barack Obama"
            ],
            "correctAnswer": "Jair Bolsonaro"
        },
        {
            "id": 3,
            "level": 0,
            "statement": "O holocausto é a solução definitiva para os judeus",
            "options": ["Winston Churchill",
                "Josef Stalin",
                "Joseph Goebbels",
                "Abraham Lincoln",
                "Napoleão Bonaparte",
                "Adolf Eichmann",
                "Paula Hitler",
                "Mao Tsé-Tung"
            ],
            "correctAnswer": "Adolf Hitler"
        },
        {
            "id": 4,
            "level": 0,
            "statement": "Vou construir um grande muro(...). Marquem minhas palavras",
            "options": ["Josef Stalin",
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
                "Justin Trudeau"
            ],
            "correctAnswer": "Donald Trump"
        },
        {
            "id": 5,
            "level": 0,
            "statement": "Não tem coisa mais fácil do que cuidar de pobre, no Brasil. Com R$ 10, o pobre se contenta",
            "options": ["Jair Bolsonaro",
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
                "João Goulart"
            ],
            "correctAnswer": "Lula"
        },
        {
            "id": 6,
            "level": 1,
            "statement": "Eu fui num quilombola(...). O afrodescendente mais leve lá pesava sete arrobas. Não fazem nada. Eu acho que nem pra procriadores servem mais",
            "options": ["Lula",
                "Michel Temer",
                "Donald Trump",
                "Fernando Haddad",
                "Ciro Gomes",
                "Aécio Neves"
            ],
            "correctAnswer": "Jair Bolsonaro"
        },
        {
            "id": 7,
            "level": 1,
            "statement": "As massas são femininas e idiotas",
            "options": ["Jair Bolsonaro",
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
                "Geraldo Alckmin"
            ],
            "correctAnswer": "Adolf Hitler"
        },
        {
            "id": 8,
            "level": 1,
            "statement": "Eu gosto dos chineses. Eu vendi um apartamento por US$ 15 milhões para alguém da China. Como não gostar deles?",
            "options": ["Geraldo Alckmin",
                "Henrique Meirelles",
                "Bill Clinton",
                "John F. Kennedy",
                "Ronald Reagan",
                "George W. Bush",
                "Bashar al-Assad"
            ],
            "correctAnswer": "Donald Trump"
        },
        {
            "id": 9,
            "level": 1,
            "statement": "Quando você é uma estrela, te deixam fazer de tudo. Pegar na b*ta. Dá para fazer qualquer coisa",
            "options": ["Alexandre Frota",
                "Johnny Depp",
                "Leonardo DiCaprio",
                "Biel",
                "Silvio Santos",
                "Bruno Mars",
                "Pedro Bial",
                "Chris Brown",
                "Cristiano Ronaldo",
                "Charlie Sheen",
                "Jair Bolsonaro"
            ],
            "correctAnswer": "Donald Trump"
        },
        {
            "id": 10,
            "level": 1,
            "statement": "Eu poderia parar no meio da Quinta Avenida e atirar em alguém, e não perderia quaisquer eleitores, ok?",
            "options": ["Jair Bolsonaro",
                "Lula",
                "Fernando Haddad",
                "George W. Bush",
                "Cabo Daciolo",
                "João Amoêdo",
                "Álvaro Dias",
                "Aécio Neves",
                "Ciro Gomes",
                "Barack Obama",
                "Ronald Reagan"
            ],
            "correctAnswer": "Donald Trump"
        },
        {
            "id": 11,
            "level": 1,
            "statement": "Feminismo? Eu acho que é coisa de quem não tem o que fazer",
            "options": ["Jair Bolsonaro",
                "Donald Trump",
                "Hamilton Mourão",
                "Henrique Meirelles",
                "George W. Bush",
                "Geraldo Alckmin",
                "Vladimir Putin",
                "Nicolás Maduro",
                "Fidel Castro",
                "Raúl Castro",
                "Adolf Hitler"
            ],
            "correctAnswer": "Lula"
        },
        {
            "id": 12,
            "level": 2,
            "statement": "Só não te estupro porque você não merece",
            "options": ["Donald Trump",
                "Chris Brown",
                "Cristiano Ronaldo",
                "Kevin Spacey",
                "Marco Feliciano",
                "Johny Depp",
                "Michael Jackson",
                "Bill Cosby",
                "João de Deus",
                "Neymar Jr."
            ],
            "correctAnswer": "Jair Bolsonaro"
        },
        {
            "id": 13,
            "level": 2,
            "statement": "Uma mulher não pode ser submissa ao homem por causa de um prato de comida. Tem que ser submissa porque gosta dele",
            "options": ["Jair Bolsonaro",
                "Donald Trump",
                "Cabo Daciolo",
                "Henrique Meirelles",
                "Getúlio Vargas",
                "Che Guevara"
            ],
            "correctAnswer": "Lula"
        },
        {
            "id": 14,
            "level": 2,
            "statement": "Quem chega em Windhoek não parece que está em um país africano. Poucas cidades do mundo são tão limpas, tão bonitas arquitetonicamente e tem um povo tão extraordinário como tem essa cidade",
            "options": ["Donald Trump",
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
                "Vladimir Putin"
            ],
            "correctAnswer": "Lula"
        },
        {
            "id": 15,
            "level": 2,
            "statement": "O poder político nasce do cano da espingarda",
            "options": ["Che Guevara",
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
                "Jânio Quadros"
            ],
            "correctAnswer": "Mao Tsé-Tung"
        },
        {
            "id": 16,
            "level": 2,
            "statement": "Ninguém mais é capaz de indicar os desajustes de preços no supermercado do que a mulher",
            "options": ["Donald Trump",
                "Jair Bolsonaro",
                "Barack Obama",
                "Hillary Clinton"
            ],
            "correctAnswer": "Michel Temer"
        },
        {
            "id": 17,
            "level": 2,
            "statement": "Se você não tem fama de pegador e é solteiro, fica com fama de veado. Então, antes pegador que veado, né?",
            "options": ["Luan Santana",
                "Neymar Jr.",
                "Biel",
                "Brad Pitt",
                "Justin Timberlake"
            ],
            "correctAnswer": "Caio Castro"
        }
    ]
}
"""
    
}
