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
    
    var questions: [Question] = [] {
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
    
    private func sortQuestions() {
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

final class Questions: NSObject {
    
    static let shared = Questions()
    
    private var didLoadQuestions: Bool = false
    
    private var questionHolder: QuestionHolder!
    var roundQuestions: [Question] = []
    
    @objc
    func newQuestions(round: Int) {
        resetQuestions()
        loadQuestionsIfNeeded()
        
        var allRoundQuestions: Set<Question> = Set(questionHolder.questions(forLevel: QuestionLevel(id: round)))
        if (allRoundQuestions.count > 5) {
            while (roundQuestions.count != 5) {
                let rand = allRoundQuestions.randomElement()!
                roundQuestions.append(allRoundQuestions.remove(rand)!)
            }
        } else {
            roundQuestions = allRoundQuestions.shuffled()
        }
    }
    
    func resetQuestions() {
        roundQuestions.removeAll()
    }
    
    private func loadQuestionsIfNeeded() {
        if !didLoadQuestions {
            loadQuestions()
        }
    }
    
     private func loadQuestions() {
        if let path = Bundle.main.path(forResource: "DefaultQuestions", ofType: "json") {
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
