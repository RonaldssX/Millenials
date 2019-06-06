//
//  MillenialsResults.swift
//  Millenials
//
//  Created by Ronaldo Santana on 02/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

public enum EndGameResults {
    
    case Tie
    case Win
    
}

public final class MillenialsResults: Millenials {
   
    convenience init(winner: Player?) {
        self.init()
        
        self.players = Millenials.shared.players
        self.gameRound = Millenials.shared.gameRound
        self.gameHasEnded = true
        
        if (winner != nil) { self.winningPlayer = winner }
        
    }
    
    weak var winningPlayer: Player?
    
    var gameResult: EndGameResults {
        
        get {
            
            if (winningPlayer != nil) { return .Win }
            
            return .Tie
            
        }
        
    }
   
    deinit { print("results ended") }
    
    @available(*, unavailable)
    override func startGame() { }
    
    @available(*, unavailable)
    override func playerFinished() { }
    
    @available(*, unavailable)
    override func endRound() { }
    
    @available(*, unavailable)
    override func earlyEndGame() { }
    
    @available(*, unavailable)
    override func endGame() { }
    
    @available(*, unavailable)
    override func prepareForNextGame() { }
    
}


