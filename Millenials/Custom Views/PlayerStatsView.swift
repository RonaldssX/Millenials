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
            return;
            
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
        
        switch size {
            case .Small:
                titleFont       = smallTitleFont
                subtitleFont    = smallSubtitleFont
                spaceX          = smallSpaceX
                spaceY          = smallSpaceY
            case .Large:
                titleFont       = largeTitleFont
                subtitleFont    = largeSubtitleFont
                spaceX          = largeSpaceX
                spaceY          = largeSpaceY
        }
    }
}

public class PlayerStatsView: UIView {
    
    var style: StatsViewStyle! {
        
        didSet {
            
            guard (self.style != nil) else { return }
            colors.setColors(for: self.style)
        }
        
    }
    
    var size: StatsViewSize! {
        
        didSet {
            
            guard (self.size != nil) else { return }
            sizes.setSizes(for: self.size)
        }
        
    }
    
    private var colors = StatsColors()
    private var sizes = StatsSizes()
    
    private var player: Player?
    
    public var pointStackView: UIStackView! {
        
        willSet { self.pointStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.pointStackView != nil) else { return }
            
            self.pointStackView.alignment = .leading
            self.pointStackView.axis = .vertical
            self.pointStackView.distribution = .equalCentering
            self.pointStackView.spacing = 10
            
            var trailing: NSLayoutConstraint
            
            addSubview(self.pointStackView)
            self.pointStackView.translatesAutoresizingMaskIntoConstraints = false
            self.pointStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sizes.spaceX).isActive = true
            if #available(iOS 11.0, *) {
                trailing = self.pointStackView.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: centerXAnchor, multiplier: 2/3)
            } else {
                trailing = self.pointStackView.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor, constant: (2*bounds.width)/3)
            }
            trailing.isActive = true
            trailing.identifier = "leading"
            self.pointStackView.topAnchor.constraint(equalTo: topAnchor, constant: sizes.spaceY).isActive = true
            self.pointStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sizes.spaceY).isActive = true
            
        }
        
    }

    private var pointsNumberLabel: UILabel! {
        
        willSet { self.pointsNumberLabel?.removeFromSuperview() }
       
        didSet {
            
            guard (self.pointsNumberLabel != nil) else { return }
            
            self.pointsNumberLabel.backgroundColor = .clear
            self.pointsNumberLabel.font = .defaultFont(size: sizes.titleFont, weight: .semiBold)
            self.pointsNumberLabel.numberOfLines = 1
            self.pointsNumberLabel.text = "\((player != nil ? player!.points : _currentPlayer!.points))"
            self.pointsNumberLabel.textAlignment = .center
            self.pointsNumberLabel.textColor = colors.text
            
            pointStackView.addArrangedSubview(self.pointsNumberLabel)
            self.pointsNumberLabel.widthAnchor.constraint(equalTo: pointStackView.widthAnchor).isActive = true
            
            /*
            addSubview(self.pointsNumberLabel)
            self.pointsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            self.pointsNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sizes.spaceX).isActive = true
            self.pointsNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: sizes.spaceY).isActive = true
            */
        }
        
    }
    
    private var pointsSubtitleLabel: UILabel! {
        
        willSet { self.pointsSubtitleLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.pointsSubtitleLabel != nil) else { return }
            
            self.pointsSubtitleLabel.adjustsFontSizeToFitWidth = true
            self.pointsSubtitleLabel.backgroundColor = .clear
            self.pointsSubtitleLabel.font = .defaultFont(size: sizes.subtitleFont, weight: .regular)
            self.pointsSubtitleLabel.numberOfLines = 1
            self.pointsSubtitleLabel.text = localized("Points")
            self.pointsSubtitleLabel.textAlignment = .center
            self.pointsSubtitleLabel.textColor = colors.text
            
            pointStackView.addArrangedSubview(self.pointsSubtitleLabel)
            self.pointsSubtitleLabel.widthAnchor.constraint(equalTo: pointStackView.widthAnchor).isActive = true
            
        }
        
    }
    
    public var roundStackView: UIStackView! {
        
        willSet { self.roundStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.roundStackView != nil) else { return }
            
            self.roundStackView.alignment = .trailing
            self.roundStackView.axis = .vertical
            self.roundStackView.distribution = .equalCentering
            self.roundStackView.spacing = 10
            
            var trailing: NSLayoutConstraint
            
            addSubview(self.roundStackView)
            self.roundStackView.translatesAutoresizingMaskIntoConstraints = false
            self.roundStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sizes.spaceX).isActive = true
            if #available(iOS 11.0, *) {
               trailing = self.roundStackView.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: centerXAnchor, multiplier: 2/3)
            } else {
                trailing = self.roundStackView.leadingAnchor.constraint(greaterThanOrEqualTo: centerXAnchor, constant: (2*bounds.width)/3)
            }
            trailing.isActive = true
            trailing.identifier = "trailing"
            self.roundStackView.topAnchor.constraint(equalTo: topAnchor, constant: sizes.spaceY).isActive = true
            self.roundStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -sizes.spaceY).isActive = true
            
        }
        
    }
    
    var roundNumberLabel: UILabel! {
        
        willSet { self.roundNumberLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.roundNumberLabel != nil) else { return }
            
            self.roundNumberLabel.backgroundColor = .clear
            self.roundNumberLabel.font = .defaultFont(size: sizes.titleFont, weight: .semiBold)
            self.roundNumberLabel.numberOfLines = 1
            self.roundNumberLabel.text = "\(Millenials.shared.gameRound)º"
            self.roundNumberLabel.textAlignment = .center
            self.roundNumberLabel.textColor = colors.text
            
            roundStackView.addArrangedSubview(self.roundNumberLabel)
            self.roundNumberLabel.widthAnchor.constraint(equalTo: roundStackView.widthAnchor).isActive = true
        
        }
        
    }
    
    private var roundSubtitleLabel: UILabel! {
        
        willSet { self.roundSubtitleLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.roundSubtitleLabel != nil) else { return }
            
            self.roundSubtitleLabel.backgroundColor = .clear
            self.roundSubtitleLabel.font = .defaultFont(size: sizes.subtitleFont, weight: .regular)
            self.roundSubtitleLabel.numberOfLines = 0
            self.roundSubtitleLabel.text = localized("Round")
            self.roundSubtitleLabel.textAlignment = .center
            self.roundSubtitleLabel.textColor = colors.text
            
            roundStackView.addArrangedSubview(self.roundSubtitleLabel)
            self.roundSubtitleLabel.widthAnchor.constraint(equalTo: roundStackView.widthAnchor).isActive = true
            
        }
        
    }
    
    private func initializeViews() {
        
        self.pointStackView = UIStackView()
        self.pointsNumberLabel = UILabel()
        self.pointsSubtitleLabel = UILabel()
        
        self.roundStackView = UIStackView()
        self.roundNumberLabel = UILabel()
        self.roundSubtitleLabel = UILabel()
        
        layoutIfNeeded()
    }
    
    func configure(with viewController: UIViewController, _ customPlayer: Player? = nil) {
        configure(with: viewController.view, customPlayer)
    }
    
    func configure(with view: UIView, _ customPlayer: Player? = nil) {
     
        self.player = customPlayer
        backgroundColor = colors.background
        clipsToBounds = true
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var leading: NSLayoutConstraint
        leading = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ((isiPad && (size == .Small)) ? 60 : 0))
        leading.identifier = "masterLeading"
        leading.isActive = true
        
        var trailing: NSLayoutConstraint
        trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ((isiPad && (size == .Small)) ? -60 : 0))
        trailing.identifier = "masterTrailing"
        trailing.isActive = true
        initializeViews()
        
    }
    
    func customConfig(with view: UIView, _ customPlayer: Player? = nil, rightHeader header: String, rightSubtitle subtitle: String) {
        
        configure(with: view, customPlayer)
        
        self.roundNumberLabel.text = header
        self.roundSubtitleLabel.text = subtitle
        
        self.roundNumberLabel.font = .defaultFont(size: 18, weight: .semiBold)
        
    }
    
}
