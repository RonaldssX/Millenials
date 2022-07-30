//
//  UIFont.swift
//  Millenials
//
//  Created by Ronaldo Santana on 22/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIFont

enum DefaultFontWeight {
    
    case thin
    case extraLight
    case light
    case regular
    case medium
    case heavy
    case semiBold
    case bold
    case ExtraBold
    
}

extension UIFont {
    
    class func defaultFont(size: CGFloat, weight: DefaultFontWeight) -> UIFont {
        
        var fontName: String!        
        
        switch weight {
            
            case .thin:             fontName = "Raleway-Thin"
            case .extraLight:       fontName = "Raleway-ExtraLight"
            case .light:            fontName = "Raleway-Light"
            case .regular:          fontName = "Raleway"
            case .medium:           fontName = "Raleway-Medium"
            case .heavy:            fontName = "Raleway-Heavy"
            case .semiBold:         fontName = "Raleway-SemiBold"
            case .bold:             fontName = "Raleway-Bold"
            case .ExtraBold:        fontName = "Raleway-ExtraBold"
            @unknown default:       fontName = "Raleway"
        }
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
    
}
