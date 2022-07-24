//
//  PlayerStatsView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerStatsViewProtocol {
    func configure(with player: Player, viewStyle: PlayerStatusViewStyles)
    func configure(with player: Player)
}

final class PlayerStatsView: UIView {
        
    private var viewStyle: PlayerStatusViewStyles!
    private weak var player: Player?
    
    private lazy var pointsView: PlayerStatsAccessoryView = {
        let view = PlayerStatsAccessoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var roundsView: PlayerStatsAccessoryView = {
        let view = PlayerStatsAccessoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

// MARK: PlayerStatsViewProtocol conforms
extension PlayerStatsView: PlayerStatsViewProtocol {
    
    func configure(with player: Player) {
        self.player = player
        if (viewStyle != nil) {
            configureView()
            return
        }
        self.viewStyle = .default
        setupView()
    }
    
    func configure(with player: Player, viewStyle: PlayerStatusViewStyles) {
        self.player = player
        self.viewStyle = viewStyle
        setupView()
    }
    
}

// MARK: - View configuration
extension PlayerStatsView {
    
    private func setupView() {
        backgroundColor = viewStyle.colors.background
        clipsToBounds = true
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        
        addSubview(pointsView)
        addSubview(roundsView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            pointsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewStyle.sizes.spaceX),
            pointsView.topAnchor.constraint(equalTo: topAnchor, constant: viewStyle.sizes.spaceY),
            pointsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewStyle.sizes.spaceY),
            
            roundsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewStyle.sizes.spaceX),
            roundsView.topAnchor.constraint(equalTo: topAnchor, constant: viewStyle.sizes.spaceY),
            roundsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewStyle.sizes.spaceY)
            
        ])
    }
    
    private func configureView() {
        let pointsViewData = PlayerStatsAccessoryView.PlayerStatsAccessoryViewData(title: String(player?.points ?? -1), subtitle: localized("Points"))
        let roundsViewData = PlayerStatsAccessoryView.PlayerStatsAccessoryViewData(title: "\(Millenials.shared.gameRound)º", subtitle: localized("Round"))
        pointsView.configure(with: pointsViewData, viewStyle: viewStyle)
        roundsView.configure(with: roundsViewData, viewStyle: viewStyle)
    }
    
}
