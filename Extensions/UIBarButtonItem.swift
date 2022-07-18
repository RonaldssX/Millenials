//
//  UIBarButtonItem.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIBarButtonItem
import UIKit.UIColor


extension UIBarButtonItem {
    
    public dynamic var alpha: CGFloat? {
        
        get {
            
            let color = self.tintColor?.cgColor
            
            return color?.alpha
            
        }
        
        set {
            
            guard (self.tintColor != nil) else { return }
            
            let color = self.tintColor
            
            self.tintColor = color?.withAlphaComponent(newValue!)
            
        }
        
    }
    
    
}
