//
//  OpenSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 22/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class OpenSegue: UIStoryboardSegue {   
    
    override func perform() {
        
        let containerView = initialViewController.view.superview
        let navigationController = self.initialViewController.navigationController
        
        finalViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
      
        containerView?.addSubview(finalViewController.view)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.finalViewController.view.transform = .identity
            
        }, completion: {_ in
                
                navigationController?.pushViewController(self.finalViewController, animated: false)            
            
            })
    }
    
    
}
