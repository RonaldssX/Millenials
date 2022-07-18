//
//  Name.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate var callback: ((String) -> ())?


extension PlayersVC: UITextFieldDelegate {
    
    func playerName(name: @escaping ((String) -> ())) {
        
        callback = name
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if (Array(textField.text!).count > 1) {
            
            return true
            
        }
        
        return false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let should = textFieldShouldEndEditing(textField)
        
        if (should) {
            
            callback?(textField.text!)
            
            textField.resignFirstResponder()
            
        }
        
        return should
        
    }    

    
}

fileprivate class PlayerNoNameAlert: AlertView {
    
    convenience init(viewController: UIViewController) {
        self.init()
        
        self.rootViewController = viewController
    }
    
    private var okButton: UIButton! {
        
        didSet {
            
            self.okButton.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
            
            self.okButton.setTitle("Ok", for: .normal)
            
            self.okButton.layer.cornerRadius = 20
            self.okButton.clipsToBounds = true
            
        }
        
    }
    
    private func loadPlayerNoNameAlert() {
        
        backgroundColor = UIColor.View.Background.questionColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        removeConstraints(constraints)
        
        removeGestureRecognizer((gestureRecognizers?.first!)!)
        
        leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor, constant: rootViewController.view.frame.width / 5).isActive = true
        
        trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor, constant: -(rootViewController.view.frame.width / 5)).isActive = true
        
    }
    
}
