//
//  PlayerSetupView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 24/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerSetupViewDelegate: AnyObject {
    
}

protocol PlayerSetupViewAnimator {
    
}

final class PlayerSetupView: UIView {
    
    var animator: PlayerSetupViewAnimator?
    weak var delegate: PlayerSetupViewDelegate?
    var tokens: PlayerSetupViewTokens!
    
    func configure(with animator: PlayerSetupViewAnimator, delegate: PlayerSetupViewDelegate?, tokens: PlayerSetupViewTokens) {
        self.animator = animator
        self.delegate = delegate
        self.tokens = tokens
        
    }
    
}

extension PlayerSetupView: PlayerSetupViewAnimator {
    
}
