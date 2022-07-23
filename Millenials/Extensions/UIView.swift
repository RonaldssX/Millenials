//
//  UIView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIView

fileprivate let gradientName: String = "millenialsGradient"

extension UIView {
    
    open var safeGuide: UILayoutGuide {
        
        get {
            if #available(iOS 11.0, *) { return self.safeAreaLayoutGuide }
            return self.layoutMarginsGuide
        }
        
    }
    
    func hasCommonAncestor(to view: UIView) -> Bool {
        
        return(
            (self == view) || // ancestor seria ela mesma?
            self.subviews.contains(where: {$0.subviews.contains($0)}) ||
            view.subviews.contains(where: {(self.subviews.contains($0))})
        )
        
    }
    
    func gradient(colors: [UIColor]) {
        
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = colors.map({color in return color.cgColor})
        gradient.name = "millenialsGradient"
        
        self.layer.addSublayer(gradient)
        
    }
    
    func gradient(color1: UIColor, color2: UIColor) {
        gradient(colors: [color1, color2])
    }
    
    func addMillenialsGradient() {
       
        let millenialsColors: [UIColor] = [.Purple, UIColor.Purple.withAlphaComponent(0.98)]
        
        gradient(colors: millenialsColors)
        
    }
    
    func addMillenialsGradientIfNeeded() {
        if let sublayers = layer.sublayers, !(sublayers.contains(where: { $0.name == gradientName })) {
            addMillenialsGradient()
        }
    }
    
    @available(iOS 10.0, *)
    func snapshot(_ frame: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        return renderer.image(actions: { context in
            layer.render(in: context.cgContext)
        })
    }
}
