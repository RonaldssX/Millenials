//
//  IntroVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
import QuartzCore

fileprivate let millenialsLogo = UIImage(named: "Millenials_Icon")

fileprivate let soundOn = UIImage(named: "SpeakerDefault")
fileprivate let soundOff = UIImage(named: "SpeakerMute")

class IntroVC: UIViewController {
    
    private var millenialsLogoView: UIImageView! {
        
        didSet {
            
            self.millenialsLogoView.contentMode = .scaleAspectFill
            
            self.millenialsLogoView.clipsToBounds = true
            
            self.millenialsLogoView.backgroundColor = .clear
            self.millenialsLogoView.tintColor = .OffWhite
            
            view.addSubview(self.millenialsLogoView)
            
            self.millenialsLogoView.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
                self.millenialsLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                self.millenialsLogoView.heightAnchor.constraint(equalToConstant: 300).isActive = true
                
            } else {                
                
                self.millenialsLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
                self.millenialsLogoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
                
            }
            
            millenialsLogoViewConstraint = self.millenialsLogoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (isiPad ? 300 : (view.bounds.height / 2)))
            
            self.millenialsLogoView.widthAnchor.constraint(equalTo: self.millenialsLogoView.heightAnchor).isActive = true
            
            
        }
        
    }
    
    private var millenialsLogoViewConstraint: NSLayoutConstraint? {
        
        didSet {
            self.millenialsLogoViewConstraint?.isActive = true
        }
        
    }
    
    public var startButton: UIButton! {
        
        didSet {
            
            self.startButton.addTarget(self, action: #selector(startPlayerSetup), for: .touchUpInside)
            
            self.startButton.layer.cornerRadius = 8.0
            self.startButton.clipsToBounds = true
            
            self.startButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            self.startButton.setTitleColor(.LightPurple, for: .normal)
            
            self.startButton.titleLabel!.font = UIFont.defaultFont(size: 22, weight: .medium)
            self.startButton.setTitle("Jogar", for: .normal)
            
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
        
        didSet {
            
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
        
        didSet {
            
            self.aboutUsButton.addTarget(self, action: #selector(showAboutUsAlert), for: .touchUpInside)
            
            self.aboutUsButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            self.aboutUsButton.setTitleColor(.LightPurple, for: .normal)
            
            self.aboutUsButton.setTitle("?", for: .normal)
            self.aboutUsButton.titleLabel?.font = UIFont.defaultFont(size: (isiPad ? 35 : 25), weight: .medium)
            
            self.aboutUsButton.clipsToBounds = true
            
            bottomView.addSubview(self.aboutUsButton)
            self.aboutUsButton.translatesAutoresizingMaskIntoConstraints = false
           
            self.aboutUsButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: (isiPad ? 50 : 30)).isActive = true
            
            self.aboutUsButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: (isiPad ? 50 : 40)).isActive = true
            self.aboutUsButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: (isiPad ? -50 : -40)).isActive = true
            
            self.aboutUsButton.heightAnchor.constraint(equalTo: self.aboutUsButton.widthAnchor).isActive = true
                
            self.aboutUsButton.layoutIfNeeded()
            
            self.aboutUsButton.layer.cornerRadius = self.aboutUsButton.frame.width / 2
            
        }
        
    }
    
    private var soundButton: UIButton! {
        
        didSet {
            
            self.soundButton.addTarget(self, action: #selector(switchDisplayMode), for: .touchUpInside)
            
            self.soundButton.clipsToBounds = true
            
            bottomView.addSubview(self.soundButton)
            self.soundButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.soundButton.backgroundColor = UIColor.OffWhite.withAlphaComponent(0.96)
            
            self.soundButton.setImage(soundOn?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.soundButton.imageView?.tintColor = .LightPurple
            self.soundButton.imageView?.contentMode = .scaleAspectFit
           
            self.soundButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: (isiPad ? -50 : -30)).isActive = true
            
            self.soundButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: (isiPad ? 50 : 40)).isActive = true
            self.soundButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: (isiPad ? -50 : -40)).isActive = true
            
            self.soundButton.heightAnchor.constraint(equalTo: self.soundButton.widthAnchor).isActive = true
            
            self.soundButton.layoutIfNeeded()
            
            self.soundButton.layer.cornerRadius = self.soundButton.frame.width / 2
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    private func configureView() {        
        
        view.addMillenialsGradient()
        
        millenialsLogoView = UIImageView(image: millenialsLogo)
        millenialsLogoView.alpha = 0.0
        
        startButton = UIButton()
        startButton.alpha = 0.0
        
        bottomView = UIView()
        
        aboutUsButton = UIButton()
        aboutUsButton.alpha = 0.0
        
        soundButton = UIButton()
        soundButton.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLaunch()
        
        view.layoutIfNeeded()
        
    }
    
    @objc
    private func showAboutUsAlert() {
        
        let alert = AlertController()
            alert.alertMessage = "Arquitetado por Ana Caiado, \nLarrisa Duarte, \nLetícia Barbosa, \nMaria Eduarda Guedes, \nMariana Horta, \nMilena Azevedo \ne Ronaldo Santana"
            alert.alertTitle = "Aviso!"
        
        let dismissButton = UIButton()
            dismissButton.setTitle("Voltar", for: .normal)
        
            dismissButton.addTarget(alert, action: #selector(alert.dismissView), for: .touchUpInside)
        
            alert.leftButton = dismissButton
        
            alert.display(on: self)
        
    }
    
    @objc
    private func switchDisplayMode() {
        
        var finalImage: UIImage?
        
        if (AudioFeedback.shared.soundEnabled) {
            
            finalImage = soundOff?.withRenderingMode(.alwaysTemplate)
            
        } else {
            
            finalImage = soundOn?.withRenderingMode(.alwaysTemplate)
            
        }
        
        soundButton.setImage(finalImage, for: .normal)
        
        AudioFeedback.shared.soundEnabled.toggle()
        
    }
    
    @objc
    private func startPlayerSetup() {        
        
        animateExit()
        
    }
    
    @IBAction func unwindToIntro(_ segue: UIStoryboardSegue) { }  
    
}

extension IntroVC {
    
    internal func animateLaunch() {
        
        millenialsLogoViewConstraint?.constant = (isiPad ? -220 : -150)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [.preferredFramesPerSecond60, .curveEaseInOut, .allowAnimatedContent], animations: {
            
            self.millenialsLogoView.alpha = 1.0
            
            self.view.layoutIfNeeded()
            
        }, completion: {[unowned self](completed) in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction, .allowAnimatedContent], animations: {
                
                self.startButton.alpha = 1.0
                
            }, completion: {(completed) in
                
                UIView.animate(withDuration: 0.5, delay: 0.2, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction, .allowAnimatedContent], animations: {
                    
                    self.aboutUsButton.alpha = 1.0
                    self.soundButton.alpha = 1.0
                    
                }, completion: nil)
                
            })
            
        })
        
    }
    
    internal func animateExit() {
        
        millenialsLogoViewConstraint?.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.startButton.alpha = 0.0
            self.aboutUsButton.alpha = 0.0
            self.soundButton.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion: {[weak self] _ in
            
            UIImageView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self?.millenialsLogoView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
            }, completion: { _ in
                
                UIImageView.animate(withDuration: 0.4, delay: 0.0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                    
                    self?.millenialsLogoView.transform = CGAffineTransform(scaleX: 30, y: 30)
                    
                }, completion: { _ in
                    
                    self?.performSegue(withIdentifier: "IntroPlayersSegue", sender: nil)
                    
                    self?.millenialsLogoView.transform = .identity
                    
                    self?.startButton.alpha = 0.0
                    self?.aboutUsButton.alpha = 0.0
                    self?.soundButton.alpha = 0.0
                    
                })
                
                
            })
            
        })
        
    }
    
}
