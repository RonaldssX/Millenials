//
//  GameConfigs.swift
//  Millenials
//
//  Created by Ronaldo Santana on 19/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation

fileprivate let defaultConfigsName: String = "DefaultConfig"

// vai conter configs sobre o millenials,
// questoes e jogadores.
final class GameConfigs: Decodable {
    
    let isLoaded: Bool
    static private(set) var shared: GameConfigs = GameConfigs()
    
    struct MillenialsConfig: Decodable {
            
        // rounds
        let minNumberOfRounds: Int
        let maxNumberOfRounds: Int
        let numberOfRounds: Int
        
        // jogadores
        let minNumberOfPlayers: Int
        let maxNumberOfPlayers: Int
        let numberOfPlayers: Int
        
        // timer na tela do jogador
        let shouldHaveWaitTimeOnAnswerButton: Bool
        let waitTimeOnAnswerButton: Int
        
        // timer durante questoes
        let shouldDisplayTimer: Bool
        let timerDuration: Int
        
        let shouldShufflePlayers: Bool
        
        fileprivate init() {
            self.minNumberOfRounds = 0
            self.maxNumberOfRounds = 0
            self.numberOfRounds = 0
            self.minNumberOfPlayers = 0
            self.maxNumberOfPlayers = 0
            self.numberOfPlayers = 0
            self.shouldHaveWaitTimeOnAnswerButton = true
            self.waitTimeOnAnswerButton = 0
            self.shouldDisplayTimer = true
            self.timerDuration = 0
            self.shouldShufflePlayers = true
        }
        
    }
    let millenialsConfig: MillenialsConfig
    static var millenialsConfig: MillenialsConfig {
        get { return GameConfigs.shared.millenialsConfig }
    }
    
    struct QuestionsConfig: Decodable {
        
        let jsonFilename: String
        
        let easyValue: Int
        let mediumValue: Int
        let hardValue: Int
        
        let minNumberOfQuestionsPerRound: Int
        let maxNumberOfQuestionsPerRound: Int
        let numberOfQuestionsPerRound: Int
        
        let numberOfOptionsPerQuestion: Int
        let includesCorrectOption: Bool // se for falso o jogo mostra numberOfOptionsPerQuestion + 1
        
        fileprivate init() {
            self.jsonFilename = "se tu n sabe quem sou eu p saber"
            self.easyValue = 0
            self.mediumValue = 0
            self.hardValue = 0
            self.minNumberOfQuestionsPerRound = 0
            self.maxNumberOfQuestionsPerRound = 0
            self.numberOfQuestionsPerRound = 0
            self.numberOfOptionsPerQuestion = 0
            self.includesCorrectOption = true
        }
        
        
    }
    let questionsConfig: QuestionsConfig
    static var questionsConfig: QuestionsConfig {
        get { return GameConfigs.shared.questionsConfig }
    }
    
    required init() {
        self.isLoaded = false
        self.millenialsConfig = MillenialsConfig()
        self.questionsConfig = QuestionsConfig()
        self.tempShouldUseSegues = true
    }
    
    static func loadDefault() {
        if let path = Bundle.main.path(forResource: defaultConfigsName, ofType: "json") {
            let pathURL = URL(fileURLWithPath: path)
            if let file = try? Data(contentsOf: pathURL) {
                if let result = try? JSONDecoder().decode(self, from: file) {
                    Self.shared = result
                }
            }
        }
    }
    
    let tempShouldUseSegues: Bool
    
}
