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
        
        finalViewController.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        finalViewController.view.alpha = 0.8
        
        containerView?.insertSubview(self.finalViewController.view, belowSubview: initialViewController.view)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.initialViewController.view.transform = CGAffineTransform(scaleX: 30, y: 30)
            self.initialViewController.view.alpha = 0.0
            
        }, completion: { _ in
            
            navigationController?.pushViewController(self.finalViewController, animated: false)
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.initialViewController.view.alpha = 0
                
                self.finalViewController.view.transform = .identity
                self.finalViewController.view.alpha = 1.0
                
            }, completion: { _ in
                
                self.initialViewController.view.transform = .identity
                self.initialViewController.view.alpha = 1.0
                
            })
            
            
        })
        
    }
    
    func adsa() -> CALayer {
        
        guard let introVC = initialViewController as? IntroVC else { return CALayer() }
        
        let millenialsLayer = CALayer()
        
        millenialsLayer.opacity = 1.0
        millenialsLayer.isHidden = false
        millenialsLayer.masksToBounds = false
        
        millenialsLayer.frame = introVC.millenialsLogoView.bounds
        millenialsLayer.contents = introVC.millenialsLogoView.image?.cgImage
        millenialsLayer.backgroundColor = UIColor.clear.withAlphaComponent(0.0).cgColor
        
        millenialsLayer.position = introVC.view.center
        
        return millenialsLayer
        
    }
    
}
