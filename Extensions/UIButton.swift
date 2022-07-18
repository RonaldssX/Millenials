//
//  UIButton.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIButton


extension UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIButton.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveLinear], animations: {
            
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.92)
            
        }, completion: nil)
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIButton.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveLinear], animations: {
            
            self.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
    }
    
}
