//
//  MillenialsTester.swift
//  Millenials
//
//  Created by Ronaldo Santana on 29/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let names: [String] = ["naldin", "mari", "let", "jonas", "zezin", "marcin", "lu", "lucada", "celos", "felps", "janery", "andrezada", "guedes", "paty", "sofi", "ana", "lari", "pmzada", "caio", "almineto"]

final class MillenialsTester: NSObject {
    
    static let shared = MillenialsTester()
    
    public var shouldTest: Bool = false
    
    public func startKillingMachine() {
        
        print("oh shit here we go again")
        
        shouldTest = true
        
    }
    
    public func shouldRecordKillings(_ should: Bool) { return }
    
    public var currentViewController: UIViewController? {
        
        didSet {
            
            guard (self.currentViewController != nil), (shouldTest == true) else { return self.currentViewController = nil }
            
            print("view controller changed, new vc: \(self.currentViewController!.classForCoder)")
            
            if (self.currentViewController is IntroVC) { startSetup() }
            
            if (self.currentViewController is PlayersVC) { populatePlayerData() }
            
            if (self.currentViewController is PlayerChangeVC) { startQuestions() }
            
            if (self.currentViewController is QuestionVC) { answerQuestions() }
            
            if (self.currentViewController is PlayerRoundReportVC) { continueGame() }
            
            if (self.currentViewController is ConclusionVC) { ohShitHereWeGoAgain() }
            
        }
        
    }
    
    private func startSetup() {
        
        guard let introVC = currentViewController as? IntroVC else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { introVC.startButton.sendActions(for: .touchUpInside) })
        
    }
    
    private func populatePlayerData() {
        
        guard let playersVC = currentViewController as? PlayersVC else { return }
        
        let textFields = [playersVC.player1View.playerTextField, playersVC.player2View.playerTextField]
        
        let someNames = generatePlayerNames()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            textFields[0]?.text = someNames.0
            MillenialsTestData.shared.playerNamesGenerated += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                
                textFields[1]?.text = someNames.1
                MillenialsTestData.shared.playerNamesGenerated += 1
                
                self.startGame()
                
            })
            
            
        })
        
    }
    
    private func startGame() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let playersVC = currentViewController as? PlayersVC else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { playersVC.startGameButton.sendActions(for: .touchUpInside) })
        
    }
    
    private func startQuestions() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let playerChangeVC = currentViewController as? PlayerChangeVC else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: { playerChangeVC.answerQuestionsButton.sendActions(for: .touchUpInside) })
        
    }
    
    private func answerQuestions() {
        
        func checkAnswerSuggestion(_ sug: Bool) {
            
            if (sug) { answerCorrectly() }
            if (!sug) { answerIncorrectly() }
            
        }
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            
            var shouldAnswerCorrectly = Bool.random()
            
            checkAnswerSuggestion(shouldAnswerCorrectly)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                
                shouldAnswerCorrectly = Bool.random()
                
                checkAnswerSuggestion(shouldAnswerCorrectly)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    
                    shouldAnswerCorrectly = Bool.random()
                    
                    checkAnswerSuggestion(shouldAnswerCorrectly)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        
                        shouldAnswerCorrectly = Bool.random()
                        
                        checkAnswerSuggestion(shouldAnswerCorrectly)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                            
                            shouldAnswerCorrectly = Bool.random()
                            
                            checkAnswerSuggestion(shouldAnswerCorrectly)
                            
                        })
                        
                    })
                    
                })
                
            })
            
        })
        
        
    }
    
    private func continueGame() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let playerReportVC = currentViewController as? PlayerRoundReportVC else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { playerReportVC.continueButton.sendActions(for: .touchUpInside) })
        
    }
    
    private func ohShitHereWeGoAgain() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let conclusionVC = currentViewController as? ConclusionVC else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { conclusionVC.endGameButton.sendActions(for: .touchUpInside) })
        
        MillenialsTestData.shared.gamesPlayed += 1
        
    }

}

extension MillenialsTester {
    
    private func generatePlayerNames() -> (String, String) {
        
        var name1 = names.randomElement()!
        let name2 = names.randomElement()!
        
        if (name1 == name2) {
            
            while (name1 == name2) {
                
                name1 = names.randomElement()!
                
            }
            
        }
        
        return (name1, name2)
        
    }
    
    private func answerCorrectly() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let questionVC = currentViewController as? QuestionVC else { return }
        
        let correctButton = questionVC.buttons.first(where: {($0.title(for: .normal) == _currentPlayer?.currentQuestion?.correctAnswer)})
        
        print("answering question correctly")
        
        correctButton?.sendActions(for: .touchUpInside)
        
        MillenialsTestData.shared.questionsAnsweredCorrectly += 1
        
    }
    
    private func answerIncorrectly() {
        
        guard (self.currentViewController != nil), (shouldTest == true) else { return }
        
        guard let questionVC = currentViewController as? QuestionVC else { return }
        
        let randomWrongButton = questionVC.buttons.filter({($0.title(for: .normal) != _currentPlayer?.currentQuestion?.correctAnswer)}).randomButton()
        
        print("wrongly(on purpose) answering question, correct answer: \(_currentPlayer!.currentQuestion!.correctAnswer!)")
        
        randomWrongButton?.sendActions(for: .touchUpInside)
        
        MillenialsTestData.shared.questionsAnsweredIncorrectly += 1
        
    }
    
}

final fileprivate class MillenialsTestData {
    
    init() {
        
        self.roundsPlayed = 0
        self.gamesPlayed = 0
        
        self.playerNamesGenerated = 0
        
        self.questionsAnsweredCorrectly = 0
        self.questionsAnsweredIncorrectly = 0
        
    }
    
    static let shared = MillenialsTestData()
    
    public var roundsPlayed: Int {
        
        didSet {
            
            guard (self.roundsPlayed != 0) else { return }
            print("Número de rounds jogados: \(self.roundsPlayed)")
            
        }
        
    }
    
    public var gamesPlayed: Int {
        
        didSet {
            
            guard (self.gamesPlayed != 0) else { return }
            print("Número de partidas jogadas: \(self.gamesPlayed)")
            
        }
        
    }
    
    public var playerNamesGenerated: Int {
        
        didSet {
            
            guard (self.playerNamesGenerated != 0) else { return }
            print("Número de nomes gerados: \(self.playerNamesGenerated)")
            
        }
        
    }
    
    public var questionsAnsweredCorrectly: Int {
        
        didSet {
            
            guard (self.questionsAnsweredCorrectly != 0) else { return }
            print("Número de questões respondidas corretamente: \(self.questionsAnsweredCorrectly)")
            
        }
        
    }
    public var questionsAnsweredIncorrectly: Int {
        
        didSet {
            
            guard (self.questionsAnsweredIncorrectly != 0) else { return }
            print("Número de questões respondidas incorretamente: \(self.questionsAnsweredIncorrectly)")
            
        }
        
    }
    
    public var questionsAnswered: Int {
        
        get {
            
            let sum = questionsAnsweredCorrectly + questionsAnsweredIncorrectly
            
            if (sum % 10 == 0) {
                
                roundsPlayed += 1
                
                print("Número de questões respondidas: \(sum)")
                
            }
            
            return sum
            
        }
        
    }
    
}
