//
//  QuestionSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 01/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class QuestionSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let containerView = initialViewController.view.superview
        let navigationController = initialViewController.navigationController as! NavigationVC
        
        finalViewController.view.transform = CGAffineTransform(scaleX: 1, y: 0)
        finalViewController.view.center = initialViewController.view.center
        
        containerView?.addSubview(finalViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.finalViewController.view.transform = .identity
            
        }, completion: { _ in
            
            navigationController.pushViewController(self.finalViewController, animated: false)
            
        })
        
    }
    
    

}
