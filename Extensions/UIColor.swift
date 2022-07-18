//
//  UIColor.swift
//  Millenials
//
//  Created by Ronaldo Santana on 04/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(R: CGFloat, G: CGFloat, B: CGFloat, alpha: CGFloat) {
        // an init method that allows the developer to put raw
        // rgb values to init a color, instead of diving it by 255
        // (why apple?), it automatically divides the input value
        // to 255, making life much easier.
        
        self.init(red: R/255, green: G/255, blue: B/255, alpha: alpha)
    }
    
    private static let OffWhite = UIColor(R: 239, G: 245, B: 251, alpha: 1)
    private static let FullWhite = UIColor(R: 255, G: 255, B: 255, alpha: 1)
    
    private static let OffBlack = UIColor(R: 7, G: 7, B: 7, alpha: 1)
    
    private static let LightMidnightBlue = UIColor(R: 21, G: 32, B: 44, alpha: 1)
    private static let MidnightBlue = UIColor(R: 27, G: 40, B: 55, alpha: 1)
    
    private static let StrongGreen = UIColor(R: 86, G: 233, B: 55, alpha: 1)
    private static let StrongRed = UIColor(R: 230, G: 38, B: 38, alpha: 1)
    
    struct Text {
        
        static let startGameTextColor = OffWhite        
        static let answersTextColor = OffWhite
        static let questionTextColor = OffBlack
        
        
    }
    
    struct NavigationBar {
        
        static let tintColor = MidnightBlue
        static let barTintColor = OffWhite
        
    }
    
    struct View {
        
        struct Background {
        
        static let PlayersVCColor = MidnightBlue
        static let questionVCColor = LightMidnightBlue
        static let questionColor = OffWhite
        static let answersColor = MidnightBlue
        
        }
        
        struct Tint {
            
            static let questionVCTint = OffWhite
            
        }
        
        
    }
    
    struct Button {
        
        struct StartButton {
            
            static let notReadyColor = StrongGreen.withAlphaComponent(0.75)
            static let readyColor = StrongGreen
            
        }
        
    }
    
    struct Feedback {
        
        static let correctAnswerColor = StrongGreen
        static let incorrectAnswerColor = StrongRed
    }
    
    
    
}
