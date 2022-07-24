//
//  PlayerChangeViewTokens.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

struct PlayerChangeViewTokens: Decodable, Hashable, Equatable {
    
    static let defaultTokens = PlayerChangeViewTokens()
    
    func hash(into hasher: inout Hasher) {
        for property in [String() as AnyHashable] { hasher.combine(property) }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return true
    }
    
}
