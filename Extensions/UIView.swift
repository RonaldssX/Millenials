//
//  UIView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    func hasCommonAncestor(to view: UIView) -> Bool {
        
        if (self == view) {
            
            return true
            
        }
        
        for subview in self.subviews {
            
            if (view.subviews.contains(subview)) {
                
                return true
                
            }
            
        }
        
        for subview in view.subviews {
            
            if (self.subviews.contains(subview)) {
                
                return true
                
            }
            
        }
        
        return false 
        
    }
    
}
