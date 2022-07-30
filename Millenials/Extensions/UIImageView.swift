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
    
}


