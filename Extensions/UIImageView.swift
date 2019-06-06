//
//  UIImageView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 14/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    
    func rounded() {
        
        layoutIfNeeded()
        
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        
    }
    
    func fixImage() {
        
        let newSize = CGSize(width: frame.width - (frame.width / 3), height: frame.height - (frame.height / 3))
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        image = newImage
        
        layoutIfNeeded()
        
    }
    
    func addBorders(with color: UIColor? = nil) {
        
        layer.borderWidth = 3.0
        layer.borderColor = color?.cgColor
        
    }
    
}


