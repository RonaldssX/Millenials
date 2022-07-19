//
//  PlayerSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 26/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class PlayerSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let containerView = initialViewController.view.superview!.superview!.superview!.superview
        let navigationController = self.initialViewController.navigationController as? NavigationVC
        let finalVC = navigationController?.viewControllers.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC
        
        if (self.initialViewController is PlayersVC) {
            
            finalViewController.view.transform = CGAffineTransform(translationX: 0, y: containerView!.bounds.height)
            containerView?.addSubview(finalViewController.view)
            
        } else {
            
            finalVC?.reloadView()
            finalVC?.view.transform = CGAffineTransform(translationX: 0, y: containerView!.bounds.height)
            containerView?.addSubview(finalVC!.view)
            
        }
        
        containerView?.backgroundColor = .Purple
        
        UIView.animate(withDuration: 1, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.initialViewController.view.transform = CGAffineTransform(translationX: 0, y: -containerView!.bounds.height)
            
            if (self.initialViewController is PlayersVC) {
                
                self.finalViewController.view.transform = .identity
                
            } else {
                
                finalVC!.view.transform = .identity
                
            }
            
        }, completion: { _ in
            
            if (finalVC == nil) {
                navigationController?.pushViewController(self.finalViewController, animated: false)
            } else {
               _ = navigationController?.popToViewController(finalVC!, animated: false)
            }
        
        })
        
    }
    
}
