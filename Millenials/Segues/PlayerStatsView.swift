//
//  PlayerStatsView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

public enum StatsViewStyle {
    
    case Light
    case Dark
    
}

public enum StatsViewSize {
    
    case Small
    case Large
    
}

fileprivate final class StatsColors {
    
    var background: UIColor?
    var text: UIColor?
    
    private let lightBackground: UIColor = .OffWhite
    private let lightText: UIColor = .Purple
    
    private let darkBackground: UIColor = .LightPurple
    private let darkText: UIColor = .OffWhite
    
    func setColors(for style: StatsViewStyle) {
        
        if (style == .Light) {
            
            background = lightBackground
            text = lightText
         
            return
            
        }
        
            background = darkBackground
            text = darkText
        
    }
    
}

fileprivate final class StatsSizes {
    
    var titleFont: CGFloat = .zero
    var subtitleFont: CGFloat = .zero
    
    var spaceX: CGFloat = .zero
    var spaceY: CGFloat = .zero
    
    private let smallTitleFont: CGFloat = 25
    private let smallSubtitleFont: CGFloat = 12
    private let smallSpaceX: CGFloat = 20
    private let smallSpaceY: CGFloat = 10
    
    private let largeTitleFont: CGFloat = 30
    private let largeSubtitleFont: CGFloat = 15
    private let largeSpaceX: CGFloat = 40
    private let largeSpaceY: CGFloat = 15
    
    
    
    func setSizes(for size: StatsViewSize) {
        
        if (size == .Small) {
            
            titleFont = smallTitleFont
            subtitleFont = smallSubtitleFont
            
            spaceX = smallSpaceX
            spaceY = smallSpaceY
            
            return
            
        }
        
            titleFont = largeTitleFont
            subtitleFont = largeSubtitleFont
        
            spaceX = largeSpaceX
            spaceY = largeSpaceY
        
    }
    
}

class PlayerStatsView: UIView {
    
    public var style: StatsViewStyle! {
        
        didSet {
            
            guard (self.style != nil) else { return }
            
            colors.setColors(for: self.style)
            
        }
        
    }
    
    public var size: StatsViewSize! {
        
        didSet {
            
            guard (self.size != nil) else { return }
            
            sizes.setSizes(for: self.size)
            
        }
        
    }
    
    private var colors = StatsColors()
    private var sizes = StatsSizes()
    
    private var player: Player?

    private var pointsNumberLabel: UILabel! {
       
        didSet {
            
            guard (self.pointsNumberLabel != nil) else { return }
            
            self.pointsNumberLabel.backgroundColor = .clear
            self.pointsNumberLabel.textColor = colors.text
            
            self.pointsNumberLabel.textAlignment = .center
            self.pointsNumberLabel.numberOfLines = 0
            
            self.pointsNumberLabel.text = "\((player != nil ? player!.points : _currentPlayer!.points))"
            self.pointsNumberLabel.font = UIFont.defaultFont(size: sizes.titleFont, weight: .semiBold)
            
            addSubview(self.pointsNumberLabel)
            
            self.pointsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.pointsNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sizes.spaceX).isActive = true
            self.pointsNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: sizes.spaceY).isActive = true
            
            
        }
        
    }
    
    private var pointsSubtitleLabel: UILabel! {
        
        didSet {
            
            guard (self.pointsSubtitleLabel != nil) else { return }
            
            self.pointsSubtitleLabel.backgroundColor = .clear
            self.pointsSubtitleLabel.textColor = colors.text
            
            self.pointsSubtitleLabel.textAlignment = .center
            self.pointsSubtitleLabel.numberOfLines = 0
            
            self.pointsSubtitleLabel.text = "Pontos"
            self.pointsSubtitleLabel.font = UIFont.defaultFont(size: sizes.subtitleFont, weight: .regular)
            
            addSubview(self.pointsSubtitleLabel)
            
            self.pointsSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.pointsSubtitleLabel.leadingAnchor.constraint(equalTo: pointsNumberLabel.leadingAnchor).isActive = true
            self.pointsSubtitleLabel.trailingAnchor.constraint(equalTo: pointsNumberLabel.trailingAnchor).isActive = true
            
            self.pointsSubtitleLabel.topAnchor.constraint(equalTo: pointsNumberLabel.bottomAnchor, constant: 10).isActive = true
            self.pointsSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sizes.spaceY).isActive = true
            
        }
        
    }
    
    public var roundNumberLabel: UILabel! {
        
        didSet {
            
            guard (self.roundNumberLabel != nil) else { return }
            
            self.roundNumberLabel.backgroundColor = .clear
            self.roundNumberLabel.textColor = colors.text
            
            self.roundNumberLabel.textAlignment = .center
            self.roundNumberLabel.numberOfLines = 0
            
            self.roundNumberLabel.text = "\(Millenials.shared.gameRound)º"
            self.roundNumberLabel.font = UIFont.defaultFont(size: sizes.titleFont, weight: .semiBold)
            
            addSubview(self.roundNumberLabel)
            
            self.roundNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.roundNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sizes.spaceX).isActive = true
            self.roundNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: sizes.spaceY).isActive = true
            
        }
        
    }
    
    private var roundSubtitleLabel: UILabel! {
        
        didSet {
            
            guard (self.roundSubtitleLabel != nil) else { return }
            
            self.roundSubtitleLabel.backgroundColor = .clear
            self.roundSubtitleLabel.textColor = colors.text
            
            self.roundSubtitleLabel.textAlignment = .center
            self.roundSubtitleLabel.numberOfLines = 0
            
            self.roundSubtitleLabel.text = "Round"
            self.roundSubtitleLabel.font = UIFont.defaultFont(size: sizes.subtitleFont, weight: .regular)
            
            addSubview(self.roundSubtitleLabel)
            
            self.roundSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.roundSubtitleLabel.leadingAnchor.constraint(equalTo: roundNumberLabel.leadingAnchor).isActive = true
            self.roundSubtitleLabel.trailingAnchor.constraint(equalTo: roundNumberLabel.trailingAnchor).isActive = true
            
            self.roundSubtitleLabel.topAnchor.constraint(equalTo: roundNumberLabel.bottomAnchor, constant: 10).isActive = true
            self.roundSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sizes.spaceY).isActive = true
            
        }
        
    }
    
    public func configure(with viewController: UIViewController, _ customPlayer: Player? = nil) {
        
        self.player = customPlayer
        
        backgroundColor = colors.background
        
        clipsToBounds = true
        
        viewController.view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: ((isiPad && (size == .Small)) ? 60 : 0)).isActive = true
        trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: ((isiPad && (size == .Small)) ? -60 : 0)).isActive = true
        
        self.pointsNumberLabel = UILabel()
        self.pointsSubtitleLabel = UILabel()
        
        self.roundNumberLabel = UILabel()
        self.roundSubtitleLabel = UILabel()
        
        layoutIfNeeded()
        
    }
    
    public func configure(with view: UIView, _ customPlayer: Player? = nil) {
     
        self.player = customPlayer
        
        backgroundColor = colors.background
        
        clipsToBounds = true
        
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ((isiPad && (size == .Small)) ? 60 : 0)).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ((isiPad && (size == .Small)) ? -60 : 0)).isActive = true
        
        self.pointsNumberLabel = UILabel()
        self.pointsSubtitleLabel = UILabel()
        
        self.roundNumberLabel = UILabel()
        self.roundSubtitleLabel = UILabel()
        
        layoutIfNeeded()
        
    }
    
    public func customConfig(with view: UIView, _ customPlayer: Player? = nil, rightHeader header: String, rightSubtitle subtitle: String) {
        
        configure(with: view, customPlayer)
        
        self.roundNumberLabel.text = header
        self.roundSubtitleLabel.text = subtitle
        
        self.roundNumberLabel.font = UIFont.defaultFont(size: 18, weight: .semiBold)
        
    }
    
}
