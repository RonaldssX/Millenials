//
//  UIImageView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 14/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIImageView

fileprivate var count: Int = 0

extension UIImageView {
    
    func rounded() {
        
        if (frame.height != frame.width || frame.height == 0 || frame.width == 0) {
            
            reloadInputViews()
            layoutIfNeeded()
            
           rounded()
            
            return
            
        }
        
        
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        
        count = 0
        
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
}


