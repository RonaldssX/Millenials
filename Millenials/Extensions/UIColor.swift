//
//  UIColor.swift
//  Millenials
//
//  Created by Ronaldo Santana on 04/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
import MillenialsDS

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexInt = Int(hex, radix: 16)!
        let r = CGFloat((hexInt >> 16) & 0xff) / 255
        let g = CGFloat((hexInt >> 08) & 0xff) / 255
        let b = CGFloat((hexInt >> 00) & 0xff) / 255
        self.init(R: r, G: g, B: b, alpha: alpha)
    }
    
    convenience init(R: Int, G: Int, B: Int, A: Int) {
        self.init(R: CGFloat(R), G: CGFloat(G), B: CGFloat(B), alpha: CGFloat(A))
    }
    
    convenience init(R: CGFloat, G: CGFloat, B: CGFloat, alpha: CGFloat) {
        // an init method that allows the developer to put raw
        // rgb values to init a color, instead of diving it by 255
        // (why apple?), it automatically divides the input value
        // to 255, making life much easier.
        
        self.init(red: R/255, green: G/255, blue: B/255, alpha: alpha)
    }

    
    //public static let OffWhite = UIColor(R: 247, G: 241, B: 227, alpha: 1)
    //public static let Pink = UIColor(R: 229, G: 44, B: 134, alpha: 1)
    //public static let OffBlack = UIColor(R: 7, G: 7, B: 7, alpha: 1)
    //public static let Purple = UIColor(R: 44, G: 44, B: 84, alpha: 1)
    //public static let LightPurple = UIColor(R: 64, G: 64, B: 122, alpha: 1)
    static let OffWhite = ColorToken.primaryTextColor.value
    static let Pink = ColorToken.primaryButtonColor.value
    static let OffBlack = ColorToken.secondaryTextColor.value
    static let Purple = ColorToken.mainColor.value
    static let LightPurple = ColorToken.tertiaryButtonColor.value
    public static let Green = UIColor(R: 0, G: 200, B: 83, alpha: 1)
    public static let Red = UIColor(R: 244, G: 67, B: 54, alpha: 1)
    public static let Yellow = UIColor(R: 255, G: 235, B: 59, alpha: 1)
    
    public var isDark: Bool {
        
        get {
            
            let components = self.getComponents()
            
            guard (components != nil) else { return true }
            
            let red = components!.red
            let green = components!.green
            let blue = components!.blue
            
            let equation = ((red * 299) + (green * 587) + (blue * 114) ) / 1000
            
            if (equation < 125) { return false
                        } else {  return true }
            
        }
        
    }
    
    public func getComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        
        var (red, green, blue) = (CGFloat.zero, CGFloat.zero, CGFloat.zero)
        var alpha = CGFloat.zero
        
        if (getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            
            return (red, green, blue)
            
        } else { return nil }
        
    }
    
}
