//
//  QuestionVC+.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit // QuestionStatsSegue

class QuestionVC: UIViewController {
    
    private var shouldReset: Bool = false
    private var hasStartedTimer: Bool = false
    
    private var questionConstraint: NSLayoutConstraint? // 30
    private var questionView: UIView! {
        
        didSet {
            
            guard (self.questionView != nil) else { return }
            
            self.questionView.translatesAutoresizingMaskIntoConstraints = false
            self.questionView.layer.cornerRadius = 10.0
            self.questionView.clipsToBounds = true
            self.questionView.backgroundColor = .OffWhite
            
            view.addSubview(self.questionView)
            
            self.questionView.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
                self.questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                self.questionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
                
            } else {
                
                self.questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
                self.questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
                
            }
            
            self.questionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
            
            questionConstraint = self.questionView.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 80)
            questionConstraint?.isActive = true
         
        }
        
    }
    
    private var questionLabel: UILabel! {
        
        didSet {
            
            guard (self.questionLabel != nil) else { return }
            
            self.questionLabel.backgroundColor = questionView.backgroundColor
            self.questionLabel.textColor = .OffBlack
            
            self.questionLabel.textAlignment = .center
            self.questionLabel.numberOfLines = 0
            
            self.questionLabel.text = _currentQuestion?.statement
            self.questionLabel.font = UIFont.defaultFont(size: 20, weight: .medium)
            
            questionView.addSubview(self.questionLabel)
            
            self.questionLabel.translatesAutoresizingMaskIntoConstraints = false 
            
            self.questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
            self.questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
            
            self.questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
            self.questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
            
        }
        
    }
    
    public var buttons: [UIButton]! {
        
        didSet {
            
            guard (self.buttons.count == 4) else { return }
            
            self.buttons.updateAnswers()
            
            self.buttons.forEach({ button in
                
                button.addTarget(self, action: #selector(playerAnswered(_:)), for: .touchUpInside)
                
                button.layer.cornerRadius = 10
                button.clipsToBounds = true
                
                button.isExclusiveTouch = true
                
                button.titleLabel?.font = UIFont.defaultFont(size: 18, weight: .regular)
                
                button.setTitleColor(.OffWhite, for: .normal)
                button.backgroundColor = .Purple
                
                view.addSubview(button)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                
                button.leadingAnchor.constraint(equalTo: questionView.leadingAnchor).isActive = true
                button.trailingAnchor.constraint(equalTo: questionView.trailingAnchor).isActive = true 
                
                let index = self.buttons.firstIndex(of: button)!
                
                if (index == 0) {
                    
                    button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
                    
                    
                } else {
                    
                    let earlierButton = self.buttons[index - 1]
                    
                    button.topAnchor.constraint(equalTo: earlierButton.bottomAnchor, constant: 25).isActive = true
                    button.heightAnchor.constraint(equalTo: earlierButton.heightAnchor).isActive = true
                    
                    if (button == self.buttons.last!) {
                        
                        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
                        
                    }
                    
                }
                
            })
            
            view.layoutIfNeeded()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .all
        
        configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerNotAnswered), name: notification(name: "PlayerDidNotAnswerInTime"), object: nil)
        
    }
    
    private func configureView() {
        
        view.addMillenialsGradient()
        
        navigationItem.title = "Questão \(6 - _currentPlayer!.questions.count)/\(Questions.shared.roundQuestions.count)"
        
        questionView = UIView()
        
        questionLabel = UILabel()
        
        buttons = []
        
        for _ in 1...4 { buttons.append(UIButton()) }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionConstraint?.constant = (isiPad ? 120 : 30)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction], animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard (navigationItem.rightBarButtonItem != nil),
              let barTimer = navigationItem.rightBarButtonItem as? BarTimer else { return }
        
        if (!hasStartedTimer) {
            
            barTimer.startTimer()
            hasStartedTimer = true 
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard (shouldReset) else { return }
        
        guard (navigationItem.rightBarButtonItem != nil),
             let barTimer = navigationItem.rightBarButtonItem as? BarTimer else { return }
        
        barTimer.endTimer()
        navigationItem.setRightBarButton(nil, animated: false)
        
    }
    
    @objc
    private func playerNotAnswered() {
        
        buttons.disableInteraction()
        
        return noAnswer()
        
    }
    
    
    @objc
    private func playerAnswered(_ button: UIButton? = nil) {
     
        buttons.disableInteraction()
        
        if let timer = navigationItem.rightBarButtonItem as? BarTimer { timer.endTimer() }
        
        guard (button!.title(for: .normal) == _currentQuestion?.correctAnswer) else { return wrongAnswer(button!) }        
        correctAnswer(button!)
        
    }
    
    internal func refresh() {
        
        _currentPlayer?.refreshCurrentQuestion()
        
        guard ((_currentPlayer?.questions.count)! > 0) else { shouldReset = true; return displayPlayerStats() }
        
        self.updateView()
        
    }
    
    private func updateView() { updateAnimation() }
    
    private func displayPlayerStats() { exitAnimation() }
    

}

extension QuestionVC {
    
    internal func enterAnimation() {
        
    }
    
    internal func updateAnimation() {
        
       navigationItem.title = "Questão \(6 - _currentPlayer!.questions.count)/\(Questions.shared.roundQuestions.count)"
        
       UIView.animate(withDuration: 0.2, animations: {
        
        self.buttons.hideLabel()
        self.questionLabel.alpha = 0.0
        self.buttons.refreshColor()
        
       }, completion: {[unowned self](completed) in
        
            self.buttons.updateAnswers()
            self.questionLabel.text = _currentQuestion!.statement
        
            UIView.animate(withDuration: 0.2, animations: {
                
                self.buttons.showLabel()
                self.questionLabel.alpha = 1.0
                
            }, completion: {[unowned self](completed) in
                
                self.buttons.enableInteraction()
                
                guard (self.navigationItem.rightBarButtonItem != nil),
                      let timer = self.navigationItem.rightBarButtonItem as? BarTimer else { return }
                
                timer.startTimer()
                
            })
        
       })
        
    }
    
    internal func exitAnimation() {
        
        dismiss(animated: false, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.buttons.hide()
            self.questionView.alpha = 0.0
            
        }, completion: {[weak self] _ in
            
             self?.performSegue(withIdentifier: "QuestionStatsSegue", sender: nil)
            
        })
        
        
        
    }
    
    
}

extension QuestionVC {
    
    @objc
    internal func noAnswer() {
        
        _currentPlayer?.questionAnswered()
        
        displayCorrectAnswer()
        
        HapticFeedback.shared.warningFeedback()
        AudioFeedback.shared.noAnswerFeedback()
        
        waitAndRefresh()
        
    }
    
    @objc
    internal func wrongAnswer(_ btn: UIButton) {
        
        _currentPlayer?.questionAnswered(answer: btn.title(for: .normal))
        
        displayCorrectAnswer(); btn.animateColor(final: .Red)
        
        HapticFeedback.shared.errorFeedback()
        AudioFeedback.shared.errorFeedback()
        
        waitAndRefresh()
        
    }
    
    @objc
    internal func correctAnswer(_ btn: UIButton) {
        
        _currentPlayer?.questionAnswered(answer: _currentQuestion?.correctAnswer!)
        
        displayCorrectAnswer(btn)
        
        HapticFeedback.shared.sucessFeedback()
        AudioFeedback.shared.sucessFeedback()
        
        let index = buttons.firstIndex(of: btn)!
        
        let addedPointsView = AddedPointsView()
        
        if (index == 0) { addedPointsView.configure(with: view, btn) } else { addedPointsView.configure(with: view, btn, earlierButton: buttons[index - 1]) }
        
        addedPointsView.display(completionHandler: { self.refresh() })
        
    }
    
    internal func displayCorrectAnswer(_ button: UIButton? = nil) {
        
        guard (button == nil) else { return button!.animateColor(final: .Green) }
        
        let correctButton = buttons.first(where: {($0.title(for: .normal) == Millenials.shared.currentPlayer?.currentQuestion?.correctAnswer)})
        
        correctButton?.animateColor(final: .Green)
        
    }
    
    internal func waitAndRefresh() { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { self.refresh() }) }
    
}
