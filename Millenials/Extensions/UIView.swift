//
//  UIView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    open var safeGuide: UILayoutGuide {
        
        get {
            if #available(iOS 11.0, *) { return self.safeAreaLayoutGuide }
            return self.layoutMarginsGuide
        }
        
    }
    
    func hasCommonAncestor(to view: UIView) -> Bool {
        
        if (self == view) || self.subviews.contains(where: {$0.subviews.contains($0)}) || view.subviews.contains(where: {(self.subviews.contains($0))}) {
            
            return true
            
        }
        
        return false 
        
    }
    
    func gradient(color1: UIColor, color2: UIColor) {
        
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.name = "millenialsGradient"
        
        self.layer.addSublayer(gradient)
        
    }
    
    func gradient(colors: [UIColor]) {
        
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = colors.map({color in return color.cgColor})
        gradient.name = "millenialsGradient"
        
        self.layer.addSublayer(gradient)
        
    }
    
    func addMillenialsGradient() {
       
        let millenialsColors: [UIColor] = [.Purple, UIColor.Purple.withAlphaComponent(0.98)]
        
        gradient(colors: millenialsColors)
        
    }
    
    @available(iOS 10.0, *)
    func snapshot(_ frame: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        return renderer.image(actions: { context in
            layer.render(in: context.cgContext)
        })
    }
}
