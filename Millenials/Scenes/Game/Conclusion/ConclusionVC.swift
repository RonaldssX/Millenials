//
//  ConclusionVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 27/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
#if targetEnvironment(macCatalyst)
import AppKit
#endif

final class ConclusionVC: UIViewController {
    
    fileprivate var displayPlayer: Player?
    weak var coordinator: GameSceneCoordinator?
    
    private var winnerView: WinnerView? {
        
        didSet {
            
            guard (self.winnerView != nil) else { return }
            
            self.winnerView?.rootVC = self
            
            (shouldConfigureDefault ? self.winnerView?.configure() : self.winnerView?.configure(with: displayPlayer))
            
            view.addSubview(self.winnerView!)
            self.winnerView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.winnerView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            self.winnerView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            self.winnerView?.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 30).isActive = true
            
            if (shouldConfigureDefault) {
                self.winnerView?.bottomAnchor.constraint(equalTo: endGameButton.topAnchor, constant: -40).isActive = true
            } else {
                self.winnerView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
            }
            
            self.winnerView?.display()
            
        }
        
    }
    
    private var tieView: TieView? {
        
        didSet {
            
            guard (self.tieView != nil) else { return }
            
            self.tieView?.configure()
            
            view.addSubview(self.tieView!)
            self.tieView?.translatesAutoresizingMaskIntoConstraints = false
            
            self.tieView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            self.tieView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            self.tieView?.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 30).isActive = true
            self.tieView?.bottomAnchor.constraint(equalTo: endGameButton.topAnchor, constant: -40).isActive = true
            
            self.tieView?.player2Button.heightAnchor.constraint(equalTo: endGameButton.heightAnchor).isActive = true
            
            self.tieView?.player1Button.addTarget(self, action: #selector(showDetailPlayer(_:)), for: .touchUpInside)
            self.tieView?.player2Button.addTarget(self, action: #selector(showDetailPlayer(_:)), for: .touchUpInside)
        }
        
    }
    
    private var animateConstraint: NSLayoutConstraint?
    private var animateTieLabel: UILabel? {
        
        didSet {
            
            guard (self.animateTieLabel != nil) else { return }
            
            self.animateTieLabel?.text = localized("Tie")
            self.animateTieLabel?.backgroundColor = .clear
            self.animateTieLabel?.textColor = .OffWhite
            self.animateTieLabel?.font = .defaultFont(size: 20, weight: .bold)
            self.animateTieLabel?.textAlignment = .center
           
            view.addSubview(self.animateTieLabel!)
            self.animateTieLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            animateConstraint = self.animateTieLabel?.topAnchor.constraint(equalTo: view.bottomAnchor)
            animateConstraint?.isActive = true
            
            self.animateTieLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            self.animateTieLabel?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            self.animateTieLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           
            
        }
        
    }
    
    var endGameButton: UIButton! {
        
        didSet {
            
            guard (self.endGameButton != nil) else { return }
            
            self.endGameButton.layer.cornerRadius = 30
            self.endGameButton.clipsToBounds = true
            
            self.endGameButton.backgroundColor = .Pink
            self.endGameButton.setTitleColor(.OffWhite, for: .normal)
            
            self.endGameButton.titleLabel?.font = .defaultFont(size: 20, weight: .regular)
            
            view.addSubview(self.endGameButton)
            self.endGameButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.endGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
            self.endGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
            
            self.endGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
            self.endGameButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
        }
    }
    
    var shouldConfigureDefault: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .OffWhite

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layoutIfNeeded()
        animateDisplay()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }
        
    }
    
    private func configureView() {
        
        view.addMillenialsGradient()
        self.endGameButton = UIButton()
        
        if (shouldConfigureDefault) {
            (Millenials.shared.endGameResults!.winningPlayer != nil ? winConfig() : tieConfig())
        } else {
            playerDetailConfig()
        }
    }

    @objc
    private func showReviewAlert() {
        returnToIntroVC()
    }
    
    @objc
    private func returnToIntroVC() {
        if (GameConfigs.shared.tempShouldUseSegues) {
            if let nav = navigationController as? NavigationVC {
                nav.exitToMainScreen()
            }
        } else {
            coordinator?.exit()
            //navigationController?.popToRootViewController(animated: true)
            //if let introVC = navigationController?.children.first(where: { $0 is IntroVC }) as? IntroVC {
            //    navigationController?.popToViewController(introVC, animated: true)
            //} else {
            //    navigationController?.popToRootViewController(animated: true)
            //}
        }
        //Millenials.shared.prepareForNextGame()
        
    }
    
}

extension ConclusionVC {
    
    private func animateDisplay() {
        if (self.tieView != nil) { animateTie() }
        if (self.winnerView != nil) { animateWin() }
    }
    
    private func animateTie() {
        
        animateConstraint?.constant = -view.center.y
        UIView.animate(withDuration: 0.6, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.animateTieLabel?.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.view.layoutIfNeeded()
            
        }, completion: {_ in
            
            self.animateConstraint?.constant = (-self.view.frame.height + 50)
            UILabel.animate(withDuration: 0.6, delay: 0.3, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.animateTieLabel?.transform = .identity
                self.view.layoutIfNeeded()
                
            }, completion: {_ in
                
                self.tieView?.display()
                self.animateTieLabel?.removeFromSuperview()
                self.navigationItem.title = localized("Tie")
                self.endGameButton.alpha = 1.0
                
            })
        })
    }
    
    private func animateWin() {
        
    }
    
    private func animateExit() {
        
    }
    
}

extension ConclusionVC {
    
    private func tieConfig() {
        
        endGameButton?.addTarget(self, action: #selector(showReviewAlert), for: .touchUpInside)
        endGameButton?.setTitle(localized("End"), for: .normal)
        endGameButton?.alpha = 0.0
        
        self.tieView = TieView()
        self.animateTieLabel = UILabel()
        
    }
    
    @objc
    private func showDetailPlayer(_ sender: UIButton) {
        
        let newUs = ConclusionVC()
            newUs.shouldConfigureDefault = false
            newUs.displayPlayer = (sender == tieView?.player1Button ? Millenials.shared.endGameResults?.players.first : Millenials.shared.endGameResults?.players.last)
       
        if #available(iOS 13.0, *) {
            newUs.modalPresentationStyle = .automatic
            present(newUs, animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(newUs, animated: true)
        }
        
    }
    
    private func winConfig() {
        
        navigationItem.title = localized("Winner")
        
        endGameButton?.addTarget(self, action: #selector(displayNextPlayer), for: .touchUpInside)
        endGameButton?.setTitle(localized("Next"), for: .normal)
        
        self.winnerView = WinnerView()
        
    }
    
    @objc
    private func displayNextPlayer() {
        
        endGameButton?.removeTarget(self, action: #selector(displayNextPlayer), for: .touchUpInside)
        endGameButton?.addTarget(self, action: #selector(showReviewAlert), for: .touchUpInside)
        endGameButton?.setTitle(localized("End"), for: .normal)
        
        navigationItem.title = localized("Loser")
        
        winnerView?.updateView()
        
    }
    
    private func playerDetailConfig() {
        
        navigationItem.title = "\(displayPlayer!.name)"
        endGameButton?.removeFromSuperview()
        self.winnerView = WinnerView()
        
    }

}
