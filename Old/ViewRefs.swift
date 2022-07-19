//
//  ViewRefs.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit


public class Button: UIButton {
    
   @objc dynamic var color: UIColor? {
        
        get {
            
            return self.backgroundColor
            
        }
        
        set {
            
            self.backgroundColor = self.color
            
        }
    }
    
}
class Label: UILabel { }
