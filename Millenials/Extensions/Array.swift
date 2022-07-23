//
//  Array.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

infix operator ~~: ComparisonPrecedence

extension Array {
    
    public func allSatisfy(in range: Range<Int>, _ predicate: (Element) throws -> Bool) rethrows -> Bool {
        
        let rangedArray = self[range]
        
        return try rangedArray.allSatisfy(predicate)
        
        
    }
    /*
    public static func ~~ (lhs: Array, rhs: Array) -> Bool {
        guard (lhs.count == rhs.count) else { return false }
        var count = 0
        var equal = true
        lhs.forEach() { e in
            equal = rhs.contains() { $0 == e }
        }
        return true
    }*/
    
}

fileprivate let defaultAddPicture = UIImage(named: "Player_Add")!
fileprivate let defaultPicture = UIImage(named: "Player_Default")!

extension Array where Element == PlayerSetupView {
    
   func createPlayerObjects() -> [Player] {
        
        var playerObjects: [Player] = []
        
        forEach({ playerView in
            
            let player = Player(name: playerView.playerTextField.text ?? "", picture: playerView.playerPicture ?? PlayerPictures.defaultGame, color: playerView.playerPictureView.tintColor)
            
            playerObjects.append(player)
            
        })
        
        return playerObjects
        
    }
    
}

extension Array where Element == UIButton {
    
    func updateAnswers() {
        
        var answers = _currentQuestion?.answers
        var buttonsArray = Array(self)
        
        for _ in 1...5 {
            answers = answers?.shuffled()
            buttonsArray = buttonsArray.shuffled()
        }
        
        answers?.forEach() { ans in
            if buttonsArray.count > 0 {
                let btn = buttonsArray.removeFirst()
                btn.setTitle(ans, for: .normal)
            }
        }
    }

    func refreshColor() {
        forEach() { button in button.backgroundColor = .Purple }
    }
    
    func disableInteraction() {
        forEach() { button in button.isUserInteractionEnabled = false }
    }
    
    func enableInteraction() {
        forEach() { button in button.isUserInteractionEnabled = true }
    }
    
    func hideLabel() {
        forEach() { button in button.alpha = 0.0 }
    }
    
    func showLabel() {
        forEach() { button in button.alpha = 1.0 }
    }
    
    func hide() {
        forEach() { button in button.alpha = 0.0 }
    }
    
    func randomButton() -> UIButton? {
        
        var button: UIButton?
        var buttons = self
        let usedButtons = buttons.filter({($0.tag == 3)})
        var indexes: [Int] = []
        
        for usedButton in usedButtons { indexes.append(buttons.firstIndex(of: usedButton)!) }
            
        if (indexes.count > 0) {
            
            let lastIndex = indexes.last!
            
                _ = buttons.remove(at: lastIndex)
            
            if (indexes.count == 2) {
                
                _ = buttons.remove(at: (lastIndex - 1))
                
            } else if (indexes.count == 3) {
                
                _ = buttons.remove(at: indexes[lastIndex - 2])
                
            } else if (indexes.count == 4) {
                
                _ = buttons.remove(at: indexes[lastIndex - 1])
                
            }
            
        } else {
            
            let randomBool = Bool.random()
            
            if (randomBool == true) { _ = buttons.removeFirst() }
            if (randomBool == false) { _ = buttons.removeLast() }
            
        }
        
        button = buttons.randomElement()
        
        return button
        
    }
    
}
