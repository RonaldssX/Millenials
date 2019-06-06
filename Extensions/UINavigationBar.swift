//
//  UINavigationBar.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    public var isTransparent: Bool { return (shadowImage != nil) }
    
    public func transparent() {
        
        guard !(isTransparent) else {
            
            return
            
            setBackgroundImage(nil, for: .default)
            shadowImage = nil
            isTranslucent = false
            
            return
            
        }
        
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        
        
        
    }
    
}
