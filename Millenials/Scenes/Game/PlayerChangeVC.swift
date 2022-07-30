//
//  vc.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

protocol PlayerChangeVCProtocol {
    
    func configure(with player: Player)
    
}

@available(*, deprecated, message: "Use PlayerChangeFactory.make() instead")
final class PlayerChangeVC: UIViewController {
    
    var player: Player!
    
    private var playerViewConstraint: NSLayoutConstraint?
    private lazy var playerView: PlayerView = {
        let pview = PlayerView()
        pview.translatesAutoresizingMaskIntoConstraints = false
        return pview
    }()
    
    private var playerStatsViewConstraint: NSLayoutConstraint?
    private lazy var playerStatsView: PlayerStatsView = {
        let pview = PlayerStatsView()
        pview.translatesAutoresizingMaskIntoConstraints = false
        return pview
    }()
    
    private var answerQuestionsButtonConstraint: NSLayoutConstraint?
    private lazy var answerQuestionsButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 30
        btn.clipsToBounds = true
        btn.setTitleColor(.OffWhite, for: .normal)
        btn.titleLabel?.font = .defaultFont(size: 20, weight: .medium)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var shouldReset: Bool = false
    var isLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Purple
        edgesForExtendedLayout = .all
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (shouldReset) {
            shouldReset = false
            configureView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.isUserInteractionEnabled = true
        startButtonTimer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.isUserInteractionEnabled = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard (shouldReset) else { return }
        
        resetTimer()
        undoExitAnimation()
        
    }
    
    private func setupAnswerQuestionsButton() {
        if (GameConfigs.millenialsConfig.shouldHaveWaitTimeOnAnswerButton) {
            addButtonWait()
        } else {
            addButtonStart()
        }
    }
    
    private func addButtonWait() {
        // configura o botao para começar com timer
        answerQuestionsButton.backgroundColor = .Pink.withAlphaComponent(0.8)
        answerQuestionsButton.removeTarget(self, action: #selector(answerQuestions), for: .touchUpInside)
        answerQuestionsButton.addTarget(self, action: #selector(waitAction), for: .touchUpInside)
        answerQuestionsButton.setTitle("\(GameConfigs.millenialsConfig.waitTimeOnAnswerButton)", for: .normal)
    }
    
    private func addButtonStart() {
        // configura o botao para começar sem timer
        answerQuestionsButton.backgroundColor = .Pink
        answerQuestionsButton.setTitle(localized("AnswerQuestions"), for: .normal)
        answerQuestionsButton.removeTarget(self, action: #selector(waitAction), for: .touchUpInside)
        answerQuestionsButton.addTarget(self, action: #selector(self.answerQuestions), for: .touchUpInside)
    }
    
    @objc
    private func addButtonAction() {
        // chamada quando o timer no botao acaba,
        // faz a animacao para trocar o label e a cor
        
        UIButton.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .allowUserInteraction], animations: {
            
            self.answerQuestionsButton.removeTarget(self, action: #selector(self.waitAction), for: .touchUpInside)
            self.answerQuestionsButton.backgroundColor = self.answerQuestionsButton.backgroundColor?.withAlphaComponent(0.9)
            self.answerQuestionsButton.titleLabel?.alpha = 0.0
            
        }, completion: { _ in
            
            self.answerQuestionsButton.setTitle(localized("AnswerQuestions"), for: .normal)
            self.answerQuestionsButton.addTarget(self, action: #selector(self.answerQuestions), for: .touchUpInside)
            
            UIButton.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .allowUserInteraction], animations: {
                
                self.answerQuestionsButton.backgroundColor = self.answerQuestionsButton.backgroundColor?.withAlphaComponent(1.0)
                self.answerQuestionsButton.titleLabel?.alpha = 1.0
                
            })
        })
    }
    
    @objc
    private func waitAction() {
        
        answerQuestionsButton.isUserInteractionEnabled = false
        
        HapticFeedback.shared.feedback(feedbackType: .warning, repeats: 4) 
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-12, 12, -12, 12, -10, 10, -8, 8, -6, 6, -4, 4, -2, 2, 0]
        answerQuestionsButton.layer.add(shakeAnimation, forKey: "Shake")
        
        answerQuestionsButton.isUserInteractionEnabled = true
        
    }
    
    @objc
    private func answerQuestions() {
        shouldReset = true
        animateExit()
    }
    
    private func animateExit() {
        playerViewConstraint?.constant = -(playerView.bounds.height * 2)
        playerStatsViewConstraint?.constant = -(playerStatsView.bounds.height * 2)
        answerQuestionsButtonConstraint?.constant = (answerQuestionsButton.bounds.height * 2)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.playerView.alpha = 0.0
            self.playerStatsView.alpha = 0.0
            self.answerQuestionsButton.alpha = 0.0
            
            self.view.layoutIfNeeded()
            
        }) { _ in
            self.navigate()
        }
        
    }
    
    private func navigate() {
        if (GameConfigs.shared.tempShouldUseSegues) {
            performSegue(withIdentifier: "PlayerQuestionSegue", sender: nil)
        } else {
            NotificationCenter.default.post(name: notification(name: "next"), object: self)
            /*
            let questionVC = QuestionVC()
            questionVC.player = player
            navigationController?.pushViewController(questionVC, animated: false)
            questionVC.performSpecialAnimation()
             */
        }
    }
    
    private func undoExitAnimation() {
        // essas constraints tao tudo hardcoded la no setupConstraints()
        playerViewConstraint?.constant = 0
        playerStatsViewConstraint?.constant = 0
        answerQuestionsButtonConstraint?.constant = -30
        
        playerView.alpha = 1.0
        playerStatsView.alpha = 1.0
        answerQuestionsButton.alpha = 1.0
        view.layoutIfNeeded()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        timer = nil
    }

}

extension PlayerChangeVC: PlayerChangeVCProtocol {
    
    
    func configure(with player: Player) {
        self.player = player
        if !(isLoaded) {
            setupView()
        } else {
            configureView()
        }
    }
    
    
    private func setupView() {
        view.addMillenialsGradientIfNeeded()
        setupHierarchy()
        setupConstraints()
        configureView()
        isLoaded = true
    }
    
    private func setupHierarchy() {
        view.addSubview(playerView)
        view.addSubview(playerStatsView)
        view.addSubview(answerQuestionsButton)
    }
    
    private func setupConstraints() {
        
        // constraints usadas na animacao
        playerViewConstraint = playerView.topAnchor.constraint(equalTo: view.topAnchor)
        playerStatsViewConstraint = playerStatsView.topAnchor.constraint(equalTo: playerView.bottomAnchor)
        answerQuestionsButtonConstraint = answerQuestionsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([
            playerViewConstraint!,
            playerStatsViewConstraint!,
            answerQuestionsButtonConstraint!,
            
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            
            /// ((isiPad && (size == .Small)) ? 60 : 0
            playerStatsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            playerStatsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            answerQuestionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            answerQuestionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            answerQuestionsButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
            
        ])
    }
    
    private func configureView() {
        playerView.configure(with: player)
        playerStatsView.configure(with: player, viewStyle: PlayerStatusViewStyles(colors: .dark, sizes: .large))
        setupAnswerQuestionsButton()
    }
    
}

extension PlayerChangeVC {
    
    private struct Holder {
        
        var timer: Timer?
        var timeRemaining = GameConfigs.millenialsConfig.waitTimeOnAnswerButton
        
    }
    
    private static var holder = Holder()
    
    private var timer: Timer? {
        
        get { return PlayerChangeVC.holder.timer }
        set { PlayerChangeVC.holder.timer = newValue }
        
    }
    
    private var timeRemaining: Int {
        
        get { return PlayerChangeVC.holder.timeRemaining }
        set { PlayerChangeVC.holder.timeRemaining = newValue }
        
    }
    
    func startButtonTimer() {
        //if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.noPlayerTime) { return; }
        if (GameConfigs.millenialsConfig.shouldHaveWaitTimeOnAnswerButton) {
            if (timer != nil) { resetTimer() }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateButton), userInfo: nil, repeats: true)
        }
    }
    
    @objc
    private func updateButton() {
        guard (timeRemaining > 0) else { return timeRemaining = GameConfigs.millenialsConfig.waitTimeOnAnswerButton }
        
        timeRemaining--
        self.answerQuestionsButton.setTitle(String(timeRemaining), for: .normal)
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
