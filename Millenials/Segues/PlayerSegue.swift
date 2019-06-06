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
        let navigationController = self.initialViewController.navigationController
        
        finalViewController.view.transform = CGAffineTransform(translationX: 0, y: (containerView?.bounds.height)!)
        
        containerView?.addSubview(finalViewController.view)
        
        containerView?.backgroundColor = .Purple
        
        UIView.animate(withDuration: 1, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseOut], animations: {
            
            self.finalViewController.view.transform = .identity
            self.initialViewController.view.transform = CGAffineTransform(translationX: 0, y: -(containerView?.bounds.height)!)
            
        }, completion: { _ in
            
           navigationController?.pushViewController(self.finalViewController, animated: false)
            
           self.initialViewController.view.transform = .identity
            
            self.initialViewController.dismiss(animated: false, completion: nil)
            
        })
        
    }

}
