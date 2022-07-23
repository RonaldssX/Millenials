//
//  IntroVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

fileprivate let millenialsLogo = UIImage(named: "Millenials_Icon")

fileprivate let soundOn: UIImage = {
    if #available(iOS 13.0, macCatalyst 13.0, *) {
        return UIImage(systemName: "speaker.3", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
    } else {
        return UIImage(named: "SpeakerDefault")!.withRenderingMode(.alwaysTemplate)
    }
}()

fileprivate let soundOff: UIImage = {
    if #available(iOS 13.0, macCatalyst 13.0, *) {
        return UIImage(systemName: "speaker.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))!
    } else {
        return UIImage(named: "SpeakerMute")!.withRenderingMode(.alwaysTemplate)
    }
}()

final class IntroVC: UIViewController {
    
    var isShortcutLaunch: Bool = false 
    
    var millenialsLogoView: UIImageView! {
        
        willSet { self.millenialsLogoView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.millenialsLogoView != nil) else { return }
            
            self.millenialsLogoView.backgroundColor = .clear
            self.millenialsLogoView.clipsToBounds = true
            self.millenialsLogoView.contentMode = .scaleAspectFill
            self.millenialsLogoView.tintColor = .OffWhite
            
            view.addSubview(self.millenialsLogoView)
            self.millenialsLogoView.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
              self.millenialsLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.millenialsLogoView.heightAnchor.constraint(equalToConstant: 300).isActive = true
              self.millenialsLogoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
                
            } else {
                
                self.millenialsLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
                self.millenialsLogoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
                self.millenialsLogoView.heightAnchor.constraint(equalTo: self.millenialsLogoView.widthAnchor).isActive = true 
                
            }
            
            millenialsLogoViewConstraint = self.millenialsLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (isiPad ? 300 : (view.bounds.height / 2)))
            
        }
        
    }
    
    private var millenialsLogoViewConstraint: NSLayoutConstraint? {
        
        didSet {
            self.millenialsLogoViewConstraint?.isActive = true
        }
        
    }
    
    var startButton: UIButton! {
        
        willSet { self.startButton?.removeFromSuperview() }
        
        didSet {
            
            guard (self.startButton != nil) else { return }
            
            self.startButton.addTarget(self, action: #selector(startPlayerSetup), for: .touchUpInside)
            
            self.startButton.layer.cornerRadius = 8.0
            self.startButton.clipsToBounds = true
            
            self.startButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            self.startButton.setTitleColor(.LightPurple, for: .normal)
            
            self.startButton.titleLabel!.font = .defaultFont(size: (isiPad ? 26: 22), weight: .medium)
            self.startButton.setTitle(localized("PlayGame"), for: .normal)
            
            view.addSubview(self.startButton)
            
            self.startButton.translatesAutoresizingMaskIntoConstraints = false            
            
            if (isiPad) {
                
                self.startButton.leadingAnchor.constraint(equalTo: millenialsLogoView.leadingAnchor).isActive = true
                self.startButton.trailingAnchor.constraint(equalTo: millenialsLogoView.trailingAnchor).isActive = true
                
            } else {
                
                self.startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
                self.startButton.widthAnchor.constraint(equalTo: millenialsLogoView.widthAnchor).isActive = true
                
            }
            
                self.startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (isiPad ? 120 : 80)).isActive = true
                self.startButton.heightAnchor.constraint(equalToConstant: (isiPad ? 75 : 70)).isActive = true
            
        }
        
    }
    
    private var bottomView: UIView! {
        
        willSet { self.bottomView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.bottomView != nil) else { return }
            
            self.bottomView.backgroundColor = UIColor.white.withAlphaComponent(0)
            
            view.addSubview(self.bottomView)
            self.bottomView.translatesAutoresizingMaskIntoConstraints = false
            
            self.bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            self.bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            self.bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            self.bottomView.heightAnchor.constraint(equalToConstant: view.frame.height / 6).isActive = true
            
            self.bottomView.layoutIfNeeded()
            
        }
        
    }
    
    private var aboutUsButton: UIButton! {
        
        willSet { self.aboutUsButton?.removeFromSuperview() }
        
        didSet {
            
            guard (self.aboutUsButton != nil) else { return }
            
            self.aboutUsButton.addTarget(self, action: #selector(showAboutUsAlert), for: .touchUpInside)
            
            self.aboutUsButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            
            if #available(iOS 13.0, macCatalyst 13.0, *) {
                let questionMark = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
                self.aboutUsButton.setImage(questionMark, for: .normal)
                self.aboutUsButton.imageView?.tintColor = .LightPurple
                self.aboutUsButton.imageView?.contentMode = .scaleAspectFit
            } else {
                self.aboutUsButton.setTitle("?", for: .normal)
                self.aboutUsButton.setTitleColor(.LightPurple, for: .normal)
                self.aboutUsButton.titleLabel?.font = UIFont.defaultFont(size: (isiPad ? 35 : 25), weight: .medium)
            }
            
            self.aboutUsButton.clipsToBounds = true
            
            bottomView.addSubview(self.aboutUsButton)
            self.aboutUsButton.translatesAutoresizingMaskIntoConstraints = false
           
            self.aboutUsButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: (isiPad ? 50 : 30)).isActive = true
            self.aboutUsButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
            self.aboutUsButton.widthAnchor.constraint(equalToConstant: (isiPad ? 90 : 60)).isActive = true
            self.aboutUsButton.heightAnchor.constraint(equalTo: self.aboutUsButton.widthAnchor).isActive = true
                
            self.aboutUsButton.layoutIfNeeded()
            
            self.aboutUsButton.layer.cornerRadius = self.aboutUsButton.frame.width / 2
            
        }
        
    }
    
    private var soundButton: UIButton! {
        
        willSet { self.soundButton?.removeFromSuperview() }
        
        didSet {
            
            guard (self.soundButton != nil) else { return }
            
            self.soundButton.addTarget(self, action: #selector(switchDisplayMode), for: .touchUpInside)
            
            self.soundButton.clipsToBounds = true
            
            bottomView.addSubview(self.soundButton)
            self.soundButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.soundButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            
            self.soundButton.setImage(soundOn, for: .normal)
            self.soundButton.imageView?.tintColor = .LightPurple
            self.soundButton.imageView?.contentMode = .scaleAspectFit
           
            self.soundButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: (isiPad ? -50 : -30)).isActive = true
            self.soundButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
            self.soundButton.widthAnchor.constraint(equalToConstant: (isiPad ? 90 : 60)).isActive = true
            
            self.soundButton.heightAnchor.constraint(equalTo: self.soundButton.widthAnchor).isActive = true
            
            self.soundButton.layoutIfNeeded()
            
            self.soundButton.layer.cornerRadius = self.soundButton.frame.width / 2
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        debugLabels()
        
    }
    
    @nonobjc
    private func debugLabels() {
        if AppConfigs.DebugConfigs.shared.isDebuggingEnabled {
            /*
            let debugOnLabel = UILabel()
            debugOnLabel.text = "Debug: \(MDebug.shared.shouldDebug)"
            debugOnLabel.font = UIFont.defaultFont(size: 10, weight: .light)
            debugOnLabel.textColor = .OffWhite
            
            bottomView.addSubview(debugOnLabel)
            debugOnLabel.translatesAutoresizingMaskIntoConstraints = false
            
            debugOnLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
            debugOnLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -25).isActive = true
             */
            
            let debugLabel = UILabel()
            debugLabel.text = "Millenials \(Bundle.main.infoDictionary!["CFBundleShortVersionString"]!) build \(Bundle.main.infoDictionary!["CFBundleVersion"]!)"
            debugLabel.font = UIFont.defaultFont(size: 15, weight: .light)
            debugLabel.textColor = .OffWhite
            
            bottomView.addSubview(debugLabel)
            debugLabel.translatesAutoresizingMaskIntoConstraints = false
            
            debugLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
            debugLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        }
        
    }
    
    private func configureView() {        
        
        view.addMillenialsGradient()
        
        millenialsLogoView = UIImageView(image: millenialsLogo)
        millenialsLogoView.alpha = 0.0
        
        startButton = UIButton()
        startButton.alpha = 0.0
        
        bottomView = UIView()
        bottomView.alpha = 0.0
        
        aboutUsButton = UIButton()
        
        soundButton = UIButton()
        debugLabels()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard (isShortcutLaunch == false) else { return }
        animateLaunch()
        
        view.layoutIfNeeded()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }
        aboutUsButton?.layer.cornerRadius = aboutUsButton.frame.width / 2
        soundButton?.layer.cornerRadius = soundButton.frame.width / 2
        
    }
    
    @objc
    private func showAboutUsAlert() {
        
        let alert = AlertController()
        alert.alertMessage = localized("MadeBy")
        alert.alertTitle = localized("AlertDefaultTitle")
        
        let dismissButton = UIButton()
        dismissButton.setTitle(localized("Back"), for: .normal)
        dismissButton.addTarget(alert, action: #selector(alert.dismissView), for: .touchUpInside)
    
        alert.leftButton = dismissButton
        alert.display(on: self)
        
    }
    
    @objc
    private func switchDisplayMode() {
        
        let finalImage: UIImage = (AudioFeedback.shared.soundEnabled ? soundOff : soundOn)
        soundButton.setImage(finalImage, for: .normal)
        AudioFeedback.shared.soundEnabled.toggle()
        
    }
    
    @objc
    private func startPlayerSetup() {        
        
        animateExit()
        
    }
    
    @IBAction func unwindToIntro(_ segue: UIStoryboardSegue) { }
    
    @nonobjc
    func performShortcutLaunch() {
        configureView()
        millenialsLogoViewConstraint?.constant = 0
        startButton?.alpha = 0.0
        bottomView?.alpha = 0.0
        millenialsLogoView?.transform = .identity
        view?.layoutIfNeeded()
        performSegue(withIdentifier: "IntroPlayersSegue", sender: nil)
        isShortcutLaunch = false
    }
    
}

extension IntroVC {
    
    func animateLaunch() {
        
        millenialsLogoViewConstraint?.constant = (isiPad ? -220 : -150)
        
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: [.preferredFramesPerSecond60, .curveEaseInOut, .allowAnimatedContent], animations: {
            
            self.millenialsLogoView?.alpha = 1.0
            self.view?.layoutIfNeeded()
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction, .allowAnimatedContent], animations: {
                
                self.startButton?.alpha = 1.0
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.2, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction, .allowAnimatedContent], animations: {
                    
                    self.bottomView?.alpha = 1.0
                    
                })
            })
        })
        
    }
    
    func animateExit() {
        
        let animationOptions: UIView.AnimationOptions = [.preferredFramesPerSecond60, .curveEaseInOut]
        
        millenialsLogoViewConstraint?.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, options: animationOptions, animations: {
            
            self.startButton?.alpha = 0.0
            self.bottomView?.alpha = 0.0
            
            self.view?.layoutIfNeeded()
            
        }, completion: { _ in
            
            UIImageView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: animationOptions, animations: {
                
                self.millenialsLogoView?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                
            }, completion: { _ in
                self.navigate()
                self.millenialsLogoView?.transform = .identity
                
            })
        })
    }
    
    private func navigate() {
        if (GameConfigs.shared.tempShouldUseSegues) {
            performSegue(withIdentifier: "IntroPlayersSegue", sender: nil)
        } else {
            navigationController?.pushViewController(PlayersVC(), animated: false)
        }
    }
    
}
