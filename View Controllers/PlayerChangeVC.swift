//
//  vc.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let cooldownTime = 5

class PlayerChangeVC: UIViewController {
    
    private var playerViewConstraint: NSLayoutConstraint?
    public var playerView: PlayerView! {
        
        didSet {
            
            guard (self.playerView != nil) else { return }
            
            self.playerView.configure(with: self)
            
            playerViewConstraint = self.playerView.topAnchor.constraint(equalTo: view.topAnchor)
            playerViewConstraint!.isActive = true
            
        }
        
    }
    
    private var playerStatsViewConstraint: NSLayoutConstraint?
    private var playerStatsView: PlayerStatsView! {
        
        didSet {
            
            guard (self.playerStatsView != nil) else { return }
            
                   self.playerStatsView.style = .Dark
                   self.playerStatsView.size = .Large
                   self.playerStatsView.configure(with: self)
            
           playerStatsViewConstraint = self.playerStatsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height / 3)
           playerStatsViewConstraint!.isActive = true
            
        }
        
    }
    
    private var answerQuestionsButtonConstraint: NSLayoutConstraint?
    public var answerQuestionsButton: UIButton! {
        
        didSet {
            
            self.answerQuestionsButton.layer.cornerRadius = 30
            self.answerQuestionsButton.clipsToBounds = true
            
            self.answerQuestionsButton.addTarget(self, action: #selector(waitAction), for: .touchUpInside)
            
            self.answerQuestionsButton.backgroundColor = UIColor.Pink.withAlphaComponent(0.8)
            self.answerQuestionsButton.setTitleColor(.OffWhite, for: .normal)
            
            self.answerQuestionsButton.setTitle("\(cooldownTime)", for: .normal)
            self.answerQuestionsButton.titleLabel!.font = UIFont.defaultFont(size: 20, weight: .regular)
            
            view.addSubview(self.answerQuestionsButton)
            
            self.answerQuestionsButton.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
                self.answerQuestionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                self.answerQuestionsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
                
            } else {
            
                self.answerQuestionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
                self.answerQuestionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
            
            }
              answerQuestionsButtonConstraint = self.answerQuestionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
              answerQuestionsButtonConstraint!.isActive = true
            
                self.answerQuestionsButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
        }
        
    }
    
    public var shouldReset: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .all
        
        configureView()
        
    }
    
    private func configureView() {
        
        view.addMillenialsGradient()
        
        self.playerView = PlayerView()
        
        self.playerStatsView = PlayerStatsView()
        
        self.answerQuestionsButton = UIButton()
        
    }
    
    @objc
    private func addButtonAction() {
        
        UIButton.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .allowUserInteraction], animations: {[unowned self] in
            
            self.answerQuestionsButton.removeTarget(self, action: #selector(self.waitAction), for: .touchUpInside)
            
            self.answerQuestionsButton.backgroundColor = self.answerQuestionsButton.backgroundColor?.withAlphaComponent(0.9)
            
            self.answerQuestionsButton.titleLabel?.alpha = 0.0
            
        }, completion: {[weak self](completed) in
            
            self?.answerQuestionsButton.setTitle("Responder questões", for: .normal)
            self?.answerQuestionsButton.addTarget(self, action: #selector(self?.answerQuestions), for: .touchUpInside)
            
            UIButton.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .allowUserInteraction], animations: {
                
                self?.answerQuestionsButton.backgroundColor = self?.answerQuestionsButton.backgroundColor?.withAlphaComponent(1.0)
                self?.answerQuestionsButton.titleLabel?.alpha = 1.0
                
            }, completion: nil)
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startButtonTimer()
        
        guard (view.isUserInteractionEnabled) else { return view.isUserInteractionEnabled = true }
        
    }
    
    @objc
    private func waitAction() {
        
        answerQuestionsButton.isUserInteractionEnabled = false
        
        HapticFeedback.shared.feedback(feedbackType: .warning, repeats: 4) 
        
            let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
            shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
            shakeAnimation.duration = 0.5
            shakeAnimation.values = [-12, 12, -12, 12, -6, 6, -3, 3, 0]
        
            answerQuestionsButton.layer.add(shakeAnimation, forKey: "Shake")
        
        answerQuestionsButton.isUserInteractionEnabled = true
        
    }
    
    @objc
    private func answerQuestions() { shouldReset = true; animateExit() }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.isUserInteractionEnabled = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard (shouldReset) else { return }
        
        resetTimer()
        
        answerQuestionsButton.backgroundColor = UIColor.Pink.withAlphaComponent(0.8)
        answerQuestionsButton.setTitle("\(cooldownTime)", for: .normal)
        answerQuestionsButton.removeTarget(self, action: #selector(answerQuestions), for: .touchUpInside)
        answerQuestionsButton.addTarget(self, action: #selector(waitAction), for: .touchUpInside)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        timer = nil
        timeRemaining = cooldownTime
        answerQuestionsButton = nil
    }
    
    
}

extension PlayerChangeVC {
    
    private func animateExit() {
        
        performSegue(withIdentifier: "PlayerQuestionSegue", sender: nil)
        
        playerViewConstraint?.constant = -(playerView.bounds.height * 2)
        playerStatsViewConstraint?.constant = -(playerStatsView.bounds.height * 2)
        answerQuestionsButtonConstraint?.constant = (answerQuestionsButton.bounds.height * 2)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.playerView.alpha = 0.0
            self.playerStatsView.alpha = 0.0
            self.answerQuestionsButton.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
}

extension PlayerChangeVC {
    
    private struct Holder {
        
        var timer: Timer?
        var timeRemaining = cooldownTime
        
    }
    
    private static var holder = Holder()
    
    private var timer: Timer? {
        
        get {
            
            return PlayerChangeVC.holder.timer
            
        }
        
        set {
            
            PlayerChangeVC.holder.timer = newValue
            
        }
        
    }
    
    private var timeRemaining: Int {
        
        get {
            
            return PlayerChangeVC.holder.timeRemaining
            
        }
        
        set {
            
            PlayerChangeVC.holder.timeRemaining = newValue
            
        }
        
    }
    
    internal func startButtonTimer() {
        
        guard (timer == nil) else { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateButton), userInfo: nil, repeats: true)
        
    }
    
    @objc
    private func updateButton() {
        
        guard (timeRemaining > 0) else { timeRemaining = cooldownTime; return }
        
        timeRemaining -= 1
        
        self.answerQuestionsButton.setTitle("\(timeRemaining)", for: .normal)
        
        if (timeRemaining == 0) {
            
            resetTimer()
            
            addButtonAction()
            
        }
        
    }
    
    @objc
    private func resetTimer() {
        
        timer?.invalidate()
        timer = nil
        
    }
    
}
