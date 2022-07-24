//
//  PlayerStatsViewStyle.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit.UIColor

struct PlayerStatusViewStyles {
    
    static let `default`: PlayerStatusViewStyles = PlayerStatusViewStyles(colors: .light, sizes: .small)
    
    var colors: Colors
    var sizes: Sizes
    
    enum Style {
        case Light, Dark
    }
    
    enum Size {
        case Small, Large
    }
    
    struct Colors {
        
        static let light: Colors = Colors(style: .Light)
        static let dark: Colors = Colors(style: .Dark)
        
        var background: UIColor
        var text: UIColor
        
        init(style: Style) {
            switch style {
            case .Light:
                self.background = .OffWhite
                self.text = .Purple
                break;
            case .Dark:
                self.background = .LightPurple
                self.text = .OffWhite
            }
        }
        
    }
    
    struct Sizes {
        
        static let small: Sizes = Sizes(size: .Small)
        static let large: Sizes = Sizes(size: .Large)
        
        var titleFont: CGFloat
        var subtitleFont: CGFloat
        
        var spaceX: CGFloat
        var spaceY: CGFloat
        
        init(size: Size) {
            switch size {
            case .Small:
                self.titleFont = 25.0
                self.subtitleFont = 12.0
                self.spaceX = 20.0
                self.spaceY = 10.0
                break;
            case .Large:
                self.titleFont = 30.0
                self.subtitleFont = 15.0
                self.spaceX = 40.0
                self.spaceY = 15.0
            }
        }
        
    }
    
}
