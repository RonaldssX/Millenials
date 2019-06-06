//
//  UIFont.swift
//  Millenials
//
//  Created by Ronaldo Santana on 22/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIFont

public enum DefaultFontWeight {
    
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
    
    open class func defaultFont(size: CGFloat, weight: DefaultFontWeight) -> UIFont {
        
        var fontName: String!        
        
        switch weight {
            
        case .thin:
            
            fontName = "Raleway-Thin"
            
            break
            
        case .extraLight:
            
            fontName = "Raleway-ExtraLight"
            
            break
            
        case .light:
            
            fontName = "Raleway-Light"
            
            break
            
        case .regular:
            
            fontName = "Raleway"
            
            break
            
        case .medium:
            
            fontName = "Raleway-Medium"
            
            break
            
        case .heavy:
            
            fontName = "Raleway-Heavy"
            
            break
            
        case .semiBold:
            
            fontName = "Raleway-SemiBold"
            
            break
            
        case .bold:
            
            fontName = "Raleway-Bold"
            
            break
            
        case .ExtraBold:
            
            fontName = "Raleway-ExtraBold"
            
            break
            
        }        
        
        guard let defaultFont = UIFont(name: fontName, size: size) else { return UIFont.systemFont(ofSize: size) }
        
        return defaultFont
        
        
    }
    
    
}
