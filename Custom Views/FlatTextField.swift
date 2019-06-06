//
//  FlatTextField.swift
//  Millenials
//
//  Created by Ronaldo Santana on 22/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class FlatTextField: UITextField {    
    
    public var icon: UIImage? {
        
        willSet {
            
            guard (self.icon != nil) else { return }            
            
        }
        
        didSet {
            
            guard (self.icon != nil) else { return }            
            
            let iconView = UIImageView(image: self.icon)
                iconView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
                
            let paddingView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
                paddingView.contentMode = .center
            
            paddingView.addSubview(iconView)
            
            leftView = paddingView
            leftViewMode = .always
            
        }
        
    }
  

}
