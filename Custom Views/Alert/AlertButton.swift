//
//  AlertButton.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class AlertButton: UIButton {
    
    
    public var title: String? {
        
        get {
            
            return title(for: .normal)
            
        }
        
        set {
            
            setTitle(newValue, for: .normal)
            
        }
        
    }
    
    
    convenience init(title: String) {
        self.init()
        
        defer {
            
            self.title = title
            
        }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
