//
//  PlayerView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerViewProtocol {
    func configure(with player: Player)
}

class PlayerView: UIView {
    
    weak var player: Player?
    
    private lazy var playerImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .OffWhite
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .defaultFont(size: (isiPad ? 30 : 20), weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

}

extension PlayerView {
    
    private func setupView() {
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        addSubview(playerImageView)
        addSubview(playerNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerImageView.topAnchor.constraint(equalTo: topAnchor),
            playerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playerNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func configureView() {
        if let player = player {
            playerImageView.image = player.picture
            if (PlayerPictures.isDefaultPicture(player.picture)) {
                playerImageView.image = player.picture.withRenderingMode(.alwaysTemplate)
                playerImageView.contentMode = .scaleAspectFit
                playerImageView.backgroundColor = player.color
                playerImageView.tintColor = .OffWhite
            }
            playerNameLabel.text = player.name
        }

    }
    
}

// MARK: - PlayerViewProtocol conforms
extension PlayerView: PlayerViewProtocol {
    
    func configure(with player: Player) {
        self.player = player
        setupView()
    }
    
}
