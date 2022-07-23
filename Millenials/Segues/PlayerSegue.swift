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
        /*
        let navigationController = self.initialViewController.navigationController as? NavigationVC
        let playerChangeVCFromNavigation = navigationController?.viewControllers.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC
        
        if (playerChangeVCFromNavigation == nil) {
            if let fvc = finalViewController as? PlayerChangeVC {
                fvc.configure(with: Millenials.shared.currentPlayer!)
            }
            navigationController?.pushViewController(self.finalViewController, animated: false)
        } else {
            playerChangeVCFromNavigation?.configure(with: Millenials.shared.currentPlayer!)
           _ = navigationController?.popToViewController(playerChangeVCFromNavigation!, animated: false)
        }
        return;*/
        
        let containerView = initialViewController.view.superview!.superview!.superview!.superview
        let navigationController = self.initialViewController.navigationController as? NavigationVC
        let playerChangeVCFromNavigation = navigationController?.viewControllers.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC
        
        if let playerChangeVCFromNavigation = playerChangeVCFromNavigation {
            playerChangeVCFromNavigation.configure(with: Millenials.shared.currentPlayer!)
        } else {
            if (finalViewController is PlayerChangeVC) {
                (finalViewController as! PlayerChangeVC).configure(with: Millenials.shared.currentPlayer!)
            }
        }
        
        if (self.initialViewController is PlayersVC) {
            
            finalViewController.view.transform = CGAffineTransform(translationX: 0, y: containerView!.bounds.height)
            containerView?.addSubview(finalViewController.view)
            
        } else {
            
            playerChangeVCFromNavigation?.view.transform = CGAffineTransform(translationX: 0, y: containerView!.bounds.height)
            containerView?.addSubview(playerChangeVCFromNavigation!.view)
            
        }
        
        containerView?.backgroundColor = .Purple
        
        UIView.animate(withDuration: 1, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.initialViewController.view.transform = CGAffineTransform(translationX: 0, y: -containerView!.bounds.height)
            
            if (self.initialViewController is PlayersVC) {
                
                self.finalViewController.view.transform = .identity
                
            } else {
                
                playerChangeVCFromNavigation!.view.transform = .identity
                
            }
            
        }, completion: { _ in
            
            if (playerChangeVCFromNavigation == nil) {
                if let playerChangeVC = self.finalViewController as? PlayerChangeVC {
                    playerChangeVC.configure(with: Millenials.shared.currentPlayer!)
                }
                navigationController?.pushViewController(self.finalViewController, animated: false)
            } else {
                playerChangeVCFromNavigation?.configure(with: Millenials.shared.currentPlayer!)
               _ = navigationController?.popToViewController(playerChangeVCFromNavigation!, animated: false)
            }
        
        })
        
    }
    
}
