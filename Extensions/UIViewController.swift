//
//  UIViewController.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    struct HomeBar {
        
        static var homeBarVisible: Bool = true
        
    }
    
    func toggleHomeBar() {        
        
        HomeBar.homeBarVisible.toggle()
        
        _ = prefersHomeIndicatorAutoHidden
        
        setNeedsUpdateOfHomeIndicatorAutoHidden()
        
    }
    
    func toggleNavigationBar() {
        
        let navigationController = self.navigationController
        
        if (navigationController != nil && navigationController?.navigationBar != nil) {            
            navigationController?.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
            
        }
        
    }
    
  
    
}
