//
//  IntroView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol IntroViewDelegate: AnyObject {
    
    func mainButtonPressed()
    func leftButtonPressed()
    func rightButtonPressed()
    
}

protocol IntroViewAnimator: AnyObject {
    
    func performEnterAnimation(_ completion: (() -> Void)?)
    func performExitAnimation(_ completion: (() -> Void)?)
    
}

final class IntroView: UIView {
    
    private weak var delegate: IntroViewDelegate?
    weak var animator: IntroViewAnimator?
    private lazy var tokens: IntroViewTokens = .defaultTokens
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var logoImageViewConstraint: NSLayoutConstraint?
    lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: tokens.logoImageTokens.image)
        image.alpha = 0.0
        image.backgroundColor = tokens.logoImageTokens.backgroundColor
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = tokens.logoImageTokens.tintColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var mainButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(mainButtonPressed), for: .touchUpInside)
        button.alpha = 0.0
        button.layer.cornerRadius = tokens.mainButtonTokens.cornerRadius
        button.clipsToBounds = true
        button.backgroundColor = tokens.mainButtonTokens.backgroundColor
        button.setTitleColor(tokens.mainButtonTokens.titleColor, for: .normal)
        button.setTitle(tokens.mainButtonTokens.title, for: .normal)
        button.titleLabel?.font = tokens.mainButtonTokens.font
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomView: UIStackView = {
        let stack = UIStackView()
        stack.alpha = 0.0
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
        button.backgroundColor = tokens.leftButtonTokens.backgroundColor
        button.clipsToBounds = true
        if #available(iOS 13.0, macCatalyst 13.0, *) {
            button.setImage(tokens.leftButtonTokens.image, for: .normal)
            button.imageView?.tintColor = tokens.leftButtonTokens.imageTintColor
            button.imageView?.contentMode = .scaleAspectFit
        } else {
            button.setTitle(tokens.leftButtonTokens.title, for: .normal)
            button.setTitleColor(tokens.leftButtonTokens.titleColor, for: .normal)
            button.titleLabel?.font = tokens.leftButtonTokens.titleFont
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
        button.backgroundColor = tokens.rightButtonTokens.backgroundColor
        button.clipsToBounds = true
        button.setImage(tokens.rightButtonTokens.soundOn, for: .normal)
        button.imageView?.tintColor = tokens.rightButtonTokens.imageTintColor
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func mainButtonPressed() { delegate?.mainButtonPressed() }
    @objc private func leftButtonPressed() { delegate?.leftButtonPressed() }
    @objc private func rightButtonPressed() { delegate?.rightButtonPressed() }
    
}

extension IntroView {
    
    
    private func debugLabels() {
        if AppConfigs.DebugConfigs.shared.isDebuggingEnabled {
            let debugLabel = UILabel()
            debugLabel.text = "Millenials \(Bundle.main.infoDictionary!["CFBundleShortVersionString"]!) build \(Bundle.main.infoDictionary!["CFBundleVersion"]!)"
            debugLabel.font = .defaultFont(size: 15, weight: .light)
            debugLabel.textColor = .OffWhite
            
            bottomView.addSubview(debugLabel)
            debugLabel.translatesAutoresizingMaskIntoConstraints = false
            
            debugLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
            debugLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    func configure(with delegate: IntroViewDelegate?, animator: IntroViewAnimator? = nil, tokens: IntroViewTokens) {
        self.delegate = delegate
        self.animator = animator
        self.tokens = tokens
        setupView()
    }
    
    private func setupView() {
        contentView.addMillenialsGradientIfNeeded()
        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(mainButton)

        contentView.addSubview(bottomView)
        bottomView.addArrangedSubview(leftButton)
        bottomView.addArrangedSubview(rightButton)
    }
    
    private func setupConstraints() {
        logoImageViewConstraint = logoImageView.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: 300)
        NSLayoutConstraint.activate([
            logoImageViewConstraint!,
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            mainButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainButton.widthAnchor.constraint(equalTo: logoImageView.widthAnchor),
            mainButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: (isiPad ? 120 : 80)),
            mainButton.heightAnchor.constraint(equalToConstant: 70),
            
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 6),
            
            leftButton.widthAnchor.constraint(equalToConstant: (isiPad ? 90 : 60)),
            leftButton.heightAnchor.constraint(equalTo: leftButton.widthAnchor),
            
            rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor),
            rightButton.heightAnchor.constraint(equalTo: rightButton.widthAnchor)
            
        ])
    }
    
    private func configureView() {
        leftButton.layer.cornerRadius = (isiPad ? 45 : 30)
        rightButton.layer.cornerRadius = (isiPad ? 45 : 30)
        debugLabels()
        layoutIfNeeded()
    }
    
}

extension IntroView: IntroViewAnimator {
    
    func performEnterAnimation(_ completion: (() -> Void)?) {
        logoImageViewConstraint?.constant = (isiPad ? -220 : -150)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseInOut, .allowAnimatedContent]) {
            
            self.logoImageView.alpha = 1.0
            self.contentView.layoutIfNeeded()
            
        } completion: { _ in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .allowUserInteraction]) {
                
                self.mainButton.alpha = 1.0
                
            } completion: { _ in
                
                UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveLinear, .allowUserInteraction]) {
        
                    self.bottomView.alpha = 1.0
                    
                } completion: { _ in completion?() }

            }
            
        }
        
    }
    
    func performExitAnimation(_ completion: (() -> Void)?) {
        let animationOptions: UIView.AnimationOptions = [.curveEaseInOut]
        
        logoImageViewConstraint?.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, options: animationOptions) {
            
            self.mainButton.alpha = 0.0
            self.bottomView.alpha = 0.0
            
            self.contentView.layoutIfNeeded()
            
        } completion: { _ in
            
            UIImageView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: animationOptions) {
                
                self.logoImageView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                
            } completion: { _ in
                
                self.logoImageView.transform = .identity
                completion?()
                
            }

        }
        
    }
    
    
}

/*
 if (isiPad) {
     
   self.millenialsLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 self.millenialsLogoView.heightAnchor.constraint(equalToConstant: 300).isActive = true
   self.millenialsLogoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
     
 } else {
     
     self.millenialsLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
     self.millenialsLogoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
     self.millenialsLogoView.heightAnchor.constraint(equalTo: self.millenialsLogoView.widthAnchor).isActive = true
     
 }
 
 if (isiPad) {
     
     self.startButton.leadingAnchor.constraint(equalTo: millenialsLogoView.leadingAnchor).isActive = true
     self.startButton.trailingAnchor.constraint(equalTo: millenialsLogoView.trailingAnchor).isActive = true
     
 } else {
     
     self.startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     
     self.startButton.widthAnchor.constraint(equalTo: millenialsLogoView.widthAnchor).isActive = true
     
 }
 
 */
