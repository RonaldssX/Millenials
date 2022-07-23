//
//  TieView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 03/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

class TieView: UIView {
    
    var playersBackgroundView: UIView! {
        
        didSet {
            
            guard (self.playersBackgroundView != nil) else { return }
            
            self.playersBackgroundView.backgroundColor = .OffWhite
            self.playersBackgroundView.layer.cornerRadius = 12
            self.playersBackgroundView.clipsToBounds = true
            
            addSubview(self.playersBackgroundView)
            self.playersBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            self.playersBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.playersBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            self.playersBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
            
        }
        
    }
    
    var player1ImageView: UIImageView! {
        
        didSet {
            
            guard (self.player1ImageView != nil) else { return }
            
            let picture = Millenials.shared.endGameResults?.players.first?.picture
            let defaultPicture = PlayerPictures.defaultGame
            
            self.player1ImageView.contentMode = .scaleAspectFill
            
            self.player1ImageView.image = ((picture == defaultPicture) ? picture?.withRenderingMode(.alwaysTemplate) : picture)
            
            self.player1ImageView.tintColor = .OffWhite
            self.player1ImageView.backgroundColor = Millenials.shared.endGameResults?.players.first?.color
            
            playersBackgroundView.addSubview(self.player1ImageView)
            self.player1ImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.player1ImageView.leadingAnchor.constraint(equalTo: playersBackgroundView.leadingAnchor, constant: 30).isActive = true
            self.player1ImageView.trailingAnchor.constraint(equalTo: playersBackgroundView.centerXAnchor, constant: -30).isActive = true
            
            self.player1ImageView.topAnchor.constraint(equalTo: playersBackgroundView.topAnchor, constant: 25).isActive = true
            self.player1ImageView.heightAnchor.constraint(equalTo: self.player1ImageView.widthAnchor).isActive = true
            
            
        }
        
    }
    
    var player1NameLabel: UILabel! {
        
        didSet {
            
            guard (self.player1NameLabel != nil) else { return }
            
            self.player1NameLabel.backgroundColor = .clear
            self.player1NameLabel.textColor = .OffWhite
            
            self.player1NameLabel.textAlignment = .center
            self.player1NameLabel.numberOfLines = 0
            
            self.player1NameLabel.font = UIFont.defaultFont(size: 15, weight: .semiBold)
            self.player1NameLabel.text = Millenials.shared.endGameResults?.players.first?.name
            
            playersBackgroundView.addSubview(self.player1NameLabel)
            self.player1NameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.player1NameLabel.leadingAnchor.constraint(equalTo: player1ImageView.leadingAnchor).isActive = true
            self.player1NameLabel.trailingAnchor.constraint(equalTo: player1ImageView.trailingAnchor).isActive = true
            
            self.player1NameLabel.topAnchor.constraint(equalTo: player1ImageView.bottomAnchor, constant: 15).isActive = true
            self.player1NameLabel.bottomAnchor.constraint(equalTo: playersBackgroundView.bottomAnchor, constant: -30).isActive = true
            
        }
        
    }
    
    var player2ImageView: UIImageView! {
        
        didSet {
            
            guard (self.player2ImageView != nil) else { return }
            
            let picture = Millenials.shared.endGameResults?.players.last?.picture
            let defaultPicture = PlayerPictures.defaultGame
            
            self.player2ImageView.contentMode = .scaleAspectFill
            
            self.player2ImageView.image = ((picture == defaultPicture) ? picture?.withRenderingMode(.alwaysTemplate) : picture)
            
            self.player2ImageView.tintColor = .OffWhite
            self.player2ImageView.backgroundColor = Millenials.shared.endGameResults?.players.last?.color
            
            playersBackgroundView.addSubview(self.player2ImageView)
            self.player2ImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.player2ImageView.leadingAnchor.constraint(equalTo: playersBackgroundView.centerXAnchor, constant: 30).isActive = true
            self.player2ImageView.trailingAnchor.constraint(equalTo: playersBackgroundView.trailingAnchor, constant: -30).isActive = true
            
            self.player2ImageView.topAnchor.constraint(equalTo: playersBackgroundView.topAnchor, constant: 25).isActive = true
            self.player2ImageView.heightAnchor.constraint(equalTo: self.player2ImageView.widthAnchor).isActive = true
            
        }
        
    }
    
    var player2NameLabel: UILabel! {
        
        didSet {
            
            guard (self.player2NameLabel != nil) else { return }
            
            self.player2NameLabel.backgroundColor = .clear
            self.player2NameLabel.textColor = .OffWhite
            
            self.player2NameLabel.textAlignment = .center
            self.player2NameLabel.numberOfLines = 0
            
            self.player2NameLabel.font = UIFont.defaultFont(size: 15, weight: .semiBold)
            self.player2NameLabel.text = Millenials.shared.endGameResults?.players.last?.name
            
            playersBackgroundView.addSubview(self.player2NameLabel)
            self.player2NameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.player2NameLabel.trailingAnchor.constraint(equalTo: player2ImageView.trailingAnchor).isActive = true
            self.player2NameLabel.leadingAnchor.constraint(equalTo: player2ImageView.leadingAnchor).isActive = true
            
            self.player2NameLabel.topAnchor.constraint(equalTo: player2ImageView.bottomAnchor, constant: 15).isActive = true
            self.player2NameLabel.bottomAnchor.constraint(equalTo: playersBackgroundView.bottomAnchor, constant: -30).isActive = true
        }
        
    }
    
    var playersPointsLabel: UILabel! {
        
        didSet {
            
            guard (self.playersPointsLabel != nil) else { return }
            
        }
        
    }
    
    
    var player1Button: UIButton! {
        
        didSet {
        
        guard (self.player1Button != nil) else { return }
            
            self.player1Button.layer.cornerRadius = 30
            self.player1Button.clipsToBounds = true
            
            self.player1Button.backgroundColor = Millenials.shared.endGameResults!.players.first?.color
            self.player1Button.setTitleColor(.OffWhite, for: .normal)
            
            self.player1Button.titleLabel?.font = UIFont.defaultFont(size: 20, weight: .regular)
            self.player1Button.setTitle("Ver \(Millenials.shared.endGameResults!.players.first!.name)", for: .normal)
            
            addSubview(self.player1Button)
            self.player1Button.translatesAutoresizingMaskIntoConstraints = false
            
            self.player1Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
            self.player1Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
            
            self.player1Button.bottomAnchor.constraint(equalTo: player2Button.topAnchor, constant: -40).isActive = true
            self.player1Button.heightAnchor.constraint(equalTo: player2Button.heightAnchor).isActive = true
            
        }
        
    }
    
    var player2Button: UIButton! {
        
        didSet {
        
        guard (self.player2Button != nil) else { return }
            
            self.player2Button.layer.cornerRadius = 30
            self.player2Button.clipsToBounds = true
            
            self.player2Button.backgroundColor = Millenials.shared.endGameResults!.players.last?.color
            self.player2Button.setTitleColor(.OffWhite, for: .normal)
            
            self.player2Button.titleLabel?.font = UIFont.defaultFont(size: 20, weight: .regular)
            self.player2Button.setTitle("Ver \(Millenials.shared.endGameResults!.players.last!.name)", for: .normal)
            
            addSubview(self.player2Button)
            self.player2Button.translatesAutoresizingMaskIntoConstraints = false
            
            self.player2Button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
            self.player2Button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
            
            self.player2Button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true 
        
        }
        
    }
    
    public func configure() {
        
        self.playersBackgroundView = UIView()
             playersBackgroundView.backgroundColor = .clear
        
        self.player1ImageView = UIImageView()
        
            player1ImageView.layer.borderWidth = 5.0
            player1ImageView.layer.borderColor = UIColor.OffWhite.cgColor
        
        self.player1NameLabel = UILabel()
        //self.player1NameLabel.textColor = .Purple
        
        
        self.player2ImageView = UIImageView()
        
            player2ImageView.layer.borderWidth = 5.0
            player2ImageView.layer.borderColor = UIColor.OffWhite.cgColor
        
        self.player2NameLabel = UILabel()
        //self.player2NameLabel.textColor = .Purple
        
        self.player2Button = UIButton()
        self.player1Button = UIButton()
        
        
            playersBackgroundView.alpha = 0.0
        
            player1Button.alpha = 0.0
            player2Button.alpha = 0.0
        
        
    }
    
    public func display() {
        
        player1ImageView.rounded()
        player2ImageView.rounded()
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.playersBackgroundView.alpha = 1.0
            
            
        }, completion: {_ in
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.player1Button.alpha = 1.0
                self.player2Button.alpha = 1.0
                
            })
            
        })
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for imgView in [player1ImageView, player2ImageView].compactMap({ $0 }) {
            imgView.layer.cornerRadius = imgView.frame.width / 2
        }
        
    }
    
}

