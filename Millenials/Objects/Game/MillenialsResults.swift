//
//  MillenialsResults.swift
//  Millenials
//
//  Created by Ronaldo Santana on 02/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

@frozen
enum EndGameResults {
    
    case Tie
    case Win
    
}

final class MillenialsResults: Millenials {
   
    convenience init(winner: Player?) {
        self.init()
        
        self.players = Millenials.shared.players
        self.gameRound = Millenials.shared.gameRound
        self.gameHasEnded = true
        self.winningPlayer = winner
        
    }
    
    weak var winningPlayer: Player?
    weak var losingPlayer: Player? {
        
        get {
            
            if (self.winningPlayer == nil) { return nil }
            return players.first() { $0 != winningPlayer! }
            
        }
        
    }
    
    var gameResult: EndGameResults {
        
        get { (winningPlayer != nil) ? .Win : .Tie }
        
    }
    /*
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
     */
    
}
