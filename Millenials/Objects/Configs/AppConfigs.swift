//
//  AppConfigs.swift
//  Millenials
//
//  Created by Ronaldo Santana on 19/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
final class AppConfigs: Decodable {
    
    static let shared: AppConfigs = AppConfigs()
    
    final class DebugConfigs {
        
        static let shared: DebugConfigs = DebugConfigs()
        
        enum DebugMods: CaseIterable {
            
            case noPictures
            case noNames
            case noPlayerTime
            case noQuestionTimer
            case noPoints
            case allQuestions
            case infiniteQuestions
            case showMenu
            
            static var allCases: [DebugMods] = {
                return [.noPictures, .noNames, .noPlayerTime, .noQuestionTimer, .noPoints, .allQuestions, .infiniteQuestions, .showMenu]
            }()
            
        }
        
        var isDebuggingEnabled: Bool = true
        var debuggingMods: [DebugMods] = []
    }
    
}
