//
//  UIStoryboardSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboardSegue {
    
    internal var initialViewController: UIViewController {
        
        get { return self.source }
        
    }
    
    internal var finalViewController: UIViewController {
        
        get { return self.destination }
        
    }
    
}
