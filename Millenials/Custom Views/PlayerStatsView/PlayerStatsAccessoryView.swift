//
//  PlayerStatsAccessoryView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerStatsAccessoryViewProtocol {
    func configure(with data: PlayerStatsAccessoryView.PlayerStatsAccessoryViewData)
    func configure(with data: PlayerStatsAccessoryView.PlayerStatsAccessoryViewData, viewStyle: PlayerStatusViewStyles)
}

final class PlayerStatsAccessoryView: UIView {
    
    struct PlayerStatsAccessoryViewData {
        let title: String
        let subtitle: String
    }
    
    private var data: PlayerStatsAccessoryViewData!
    private var viewStyle: PlayerStatusViewStyles!
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var valueSubtitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
}

// MARK: - PlayerStatsAccessoryViewProtocol conforms
extension PlayerStatsAccessoryView: PlayerStatsAccessoryViewProtocol {
    
    func configure(with data: PlayerStatsAccessoryView.PlayerStatsAccessoryViewData) {
        self.data = data
        if (viewStyle != nil) {
            configureView()
            return;
        }
        self.viewStyle = .default
        setupView()
    }
    
    func configure(with data: PlayerStatsAccessoryView.PlayerStatsAccessoryViewData, viewStyle: PlayerStatusViewStyles) {
        self.data = data
        self.viewStyle = viewStyle
        setupView()
    }
    
}

// MARK: - View setup and configuration
extension PlayerStatsAccessoryView {
    
    private func setupView() {
        backgroundColor = viewStyle.colors.background
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(valueSubtitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            valueLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            valueSubtitleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func configureView() {
        valueLabel.font = .defaultFont(size: viewStyle.sizes.titleFont, weight: .semiBold)
        valueLabel.text = data.title
        valueLabel.textColor = viewStyle.colors.text
        
        valueSubtitleLabel.font = .defaultFont(size: viewStyle.sizes.subtitleFont, weight: .regular)
        valueSubtitleLabel.text = data.subtitle
        valueSubtitleLabel.textColor = viewStyle.colors.text
    }
    
}
