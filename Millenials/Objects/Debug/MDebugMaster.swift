//
//  MDebugMaster.swift
//  Millenials
//
//  Created by Ronaldo Santana on 09/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation

public enum debugEnum: CaseIterable {
    
    case all
    case intro
    case players
    case alerts
    
    init?(id: Int) {
        
        switch id {
            
        case 0: self = .all
        case 1: self = .intro
        case 2: self = .players
        case 3: self = .alerts
            
        default: return nil
            
        }
        
    }
    
}

public enum debugMods: CaseIterable {
    
    case noPictures
    case noNames
    case noPlayerTime
    case noQuestionTimer
    case noPoints
    case allQuestions
    case infiniteQuestions
    case showMenu
    
    public static var allCases: [debugMods] {
        get {
            return [noPictures, .noNames, .noPlayerTime, .noQuestionTimer, .noPoints, .allQuestions, .infiniteQuestions, .showMenu]
        }
    }
    
}


public final class MDebug {
    
    init() {
        
        self.shouldDebug = false
        self.debugs = []
        self.mods = []
        
    }
    
    static let shared = MDebug()
    
    var shouldDebug: Bool
    
    var debugs: [debugEnum]
    var mods: [debugMods]
    
}
