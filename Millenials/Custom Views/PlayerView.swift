//
//  PlayerView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class PlayerView: UIView {

    private var playerImageView: UIImageView! {
        
        didSet {
            
            guard (self.playerImageView != nil) else { return }
            
            self.playerImageView.contentMode = .scaleAspectFill
            
            self.playerImageView.clipsToBounds = true 
            
            defer {
                
                self.playerImageView.image = _currentPlayer?.picture
                
                if (_currentPlayer?.picture == PlayerPictures.shared.defaultAdd || _currentPlayer?.picture == PlayerPictures.shared.defaultGame) {
                    
                    self.playerImageView.image = _currentPlayer?.picture?.withRenderingMode(.alwaysTemplate)
                    
                    self.playerImageView.contentMode = .scaleAspectFit
                    
                    self.playerImageView.backgroundColor = _currentPlayer?.color
                    
                    self.playerImageView.tintColor = .OffWhite
                    
                }
              
            }
            
            addSubview(self.playerImageView)
            
            self.playerImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.playerImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            self.playerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            self.playerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
        }
        
    }
    
    private var playerNameLabel: UILabel! {
        
        didSet {
            
            guard (self.playerNameLabel != nil) else { return }
            
            self.playerNameLabel.backgroundColor = .clear
            self.playerNameLabel.textColor = .OffWhite
            
            self.playerNameLabel.textAlignment = .left
            self.playerNameLabel.numberOfLines = 0
            
            self.playerNameLabel.text = _currentPlayer?.name
            self.playerNameLabel.font = UIFont.defaultFont(size: (isiPad ? 30 : 20), weight: .bold)
            
            addSubview(self.playerNameLabel)
            
            self.playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true            
            self.playerNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true            
            
        }
        
    }   
    
    public func configure(with viewController: UIViewController?) {
        
        guard (viewController != nil) else { return }
        
        viewController?.view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: viewController!.view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: viewController!.view.trailingAnchor).isActive = true
        
        heightAnchor.constraint(equalTo: viewController!.view.heightAnchor, multiplier: 1/3).isActive = true
        
        self.playerImageView = UIImageView()
        self.playerNameLabel = UILabel()
     
        layoutIfNeeded()
        
    }
    

}
