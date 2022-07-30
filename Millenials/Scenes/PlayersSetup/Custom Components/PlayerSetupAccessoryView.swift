//
//  PlayerSetupAccessoryView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

final class PlayerSetupAccessoryView: UIView {
    
    var tokens: PlayerSetupAccessoryViewTokens!
    
    func configure(with tokens: PlayerSetupAccessoryViewTokens) {
        self.tokens = tokens
    }
    
}
