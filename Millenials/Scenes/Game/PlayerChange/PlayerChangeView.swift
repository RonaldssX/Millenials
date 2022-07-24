//
//  PlayerChangeView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerChangeViewDelegate: AnyObject {
    
    func buttonPressed()
    
}

protocol PlayerChangeViewAnimator: AnyObject {
    func buttonWaitAnimation(_ button: UIButton)
    func buttonChangeActionAnimation(_ button: UIButton, newTitle: String)
    func exitAnimation(_ completion: (() -> Void)?)
}

final class PlayerChangeView: UIView {
    
    private weak var delegate: PlayerChangeViewDelegate?
    weak var animator: PlayerChangeViewAnimator?
    private var player: Player!
    private lazy var tokens: PlayerChangeViewTokens = .defaultTokens
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topViewConstraint: NSLayoutConstraint?
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var playerView: PlayerView = {
        let view = PlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var playerStatsView: PlayerStatsView = {
        let view = PlayerStatsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var answerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.setTitleColor(.OffWhite, for: .normal)
        button.titleLabel?.font = .defaultFont(size: 20, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

extension PlayerChangeView {
    
    func configure(with player: Player, delegate: PlayerChangeViewDelegate?, animator: PlayerChangeViewAnimator?, tokens: PlayerChangeViewTokens) {
        self.player = player
        self.delegate = delegate
        self.animator = animator
        self.tokens = tokens
        setupView()
    }
    
    func reconfigure(with player: Player) {
        self.player = player
        configureView()
    }
    
    private func setupView() {
        contentView.addMillenialsGradientIfNeeded()
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(topView)
        topView.addSubview(playerView)
        topView.addSubview(playerStatsView)
        
        contentView.addSubview(answerButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            playerView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            playerView.topAnchor.constraint(equalTo: topView.topAnchor),
            playerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/3),
            
            playerStatsView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            playerStatsView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            playerStatsView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            
            answerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            answerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            answerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            answerButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
            
        ])
    }
    
    private func configureView() {
        playerView.configure(with: player)
        playerStatsView.configure(with: player, viewStyle: PlayerStatusViewStyles(colors: .dark, sizes: .large))
        configureButton()
    }
    
    private func configureButton() {
        if GameConfigs.shared.millenialsConfig.shouldHaveWaitTimeOnAnswerButton {
            answerButton.backgroundColor = .Pink.withAlphaComponent(0.8)
            answerButton.removeTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButton.addTarget(self, action: #selector(buttonPressedWithWait), for: .touchUpInside)
            answerButton.setTitle(String(GameConfigs.shared.millenialsConfig.waitTimeOnAnswerButton), for: .normal)
        } else {
            answerButton.backgroundColor = .Pink
            answerButton.removeTarget(self, action: #selector(buttonPressedWithWait), for: .touchUpInside)
            answerButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            answerButton.setTitle(localized("AnswerQuestions"), for: .normal)
        }
    }
    
    @objc private func buttonPressed() { delegate?.buttonPressed() }
    @objc private func buttonPressedWithWait() {
        HapticFeedback.shared.feedback(feedbackType: .warning, repeats: 4)
        animator?.buttonWaitAnimation(answerButton)
    }
    
}

extension PlayerChangeView: PlayerChangeViewAnimator {
    
    func buttonWaitAnimation(_ button: UIButton) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-12, 12, -12, 12, -10, 10, -8, 8, -6, 6, -4, 4, -2, 2, 0]
        button.layer.add(shakeAnimation, forKey: "Shake")
    }
    
    func buttonChangeActionAnimation(_ button: UIButton, newTitle: String) {
        
        UIButton.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction]) {
            
            button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.9)
            button.titleLabel?.alpha = 0.0
            
        } completion: { _ in
            
            button.setTitle(newTitle, for: .normal)
            UIButton.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction]) {
                
                button.backgroundColor = button.backgroundColor?.withAlphaComponent(1.0)
                button.titleLabel?.alpha = 1.0
                
            }
            
        }

    }
    
    func exitAnimation(_ completion: (() -> Void)?) {
        let playerView = self
        completion?()
    }
    
    
}
