//
//  Button.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIButton

fileprivate let animationOptions: UIView.AnimationOptions = [.preferredFramesPerSecond60, .curveLinear]

extension UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIButton.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: animationOptions, animations: {
            
            let bgColor = self.backgroundColor ?? .clear
            self.backgroundColor = bgColor.withAlphaComponent(bgColor.cgColor.alpha - 0.2)
            if (self.tag != 6969) { self.transform = CGAffineTransform(scaleX: 0.9, y: 0.92) }            
            
        })
        
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIButton.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: animationOptions, animations: {
            
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            if (self.tag != 6969) { self.transform = .identity }
            
        })
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIButton.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: animationOptions, animations: {
            
            self.transform = .identity
            let bgColor = self.backgroundColor ?? .clear
            self.backgroundColor = bgColor.withAlphaComponent(bgColor.cgColor.alpha + 0.2)
            
        })
        
    }
    
    public func animateColor(final color: UIColor) {
        UIButton.transition(with: self, duration: 0.1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.backgroundColor = color
            
        })
    }
}
