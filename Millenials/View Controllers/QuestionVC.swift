//
//  QuestionVC+.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit // QuestionStatsSegue

internal var questionCountdownTime: Int = 20

final class QuestionVC: UIViewController {
    
    private var shouldReset: Bool = false
    private var hasStartedTimer: Bool = false
    private var hasPerformedAnimation: Bool = false
    
    private var questionConstraint: NSLayoutConstraint? // 30
    private var questionView: UIView! {
        
        willSet { self.questionView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.questionView != nil) else { return }
            
            self.questionView.layer.cornerRadius = 10.0
            self.questionView.clipsToBounds = true
            self.questionView.backgroundColor = .OffWhite
            
            if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.infiniteQuestions) {
                let tap = UITapGestureRecognizer()
                tap.addTarget(self, action: #selector(answerAllQuestions))
                tap.numberOfTouchesRequired = 1
                tap.numberOfTapsRequired = 2
                self.questionView.addGestureRecognizer(tap)
            }
            
            view.addSubview(self.questionView)
            self.questionView.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private var questionLabel: UILabel! {
        
        willSet { self.questionLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.questionLabel != nil) else { return }
            
            self.questionLabel.backgroundColor = questionView.backgroundColor
            self.questionLabel.font = .defaultFont(size: 20, weight: .medium)
            self.questionLabel.numberOfLines = 0
            self.questionLabel.text = _currentQuestion?.statement
            self.questionLabel.textAlignment = .center
            self.questionLabel.textColor = .OffBlack
            
            questionView.addSubview(self.questionLabel)
            self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
    }
    
    private var buttonStackView: UIStackView! {
        
        willSet {
            if let buttonStackView = self.buttonStackView {
                buttonStackView.arrangedSubviews.forEach() { btn in btn.removeFromSuperview() }
                buttonStackView.removeFromSuperview()
            }
        }
        
        didSet {
            
            guard (self.buttonStackView != nil) else { return }
            
            self.buttonStackView.alignment = .center
            self.buttonStackView.axis = .vertical
            self.buttonStackView.isExclusiveTouch = true
            self.buttonStackView.distribution = .fillEqually
            self.buttonStackView.spacing = 25
            
            view.addSubview(self.buttonStackView)
            self.buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        }
        
    }
    
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .all
        
//        configureView()
//        if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.infiniteQuestions) {
//            let tap = UITapGestureRecognizer()
//            tap.addTarget(self, action: #selector(answerAllQuestions))
//            tap.numberOfTouchesRequired = 1
//            tap.numberOfTapsRequired = 2
//            questionView.addGestureRecognizer(tap)
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerNotAnswered), name: notification(name: "PlayerDidNotAnswerInTime"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewBasedOnLayout), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    @objc
    private func answerAllQuestions(_ sender: UITapGestureRecognizer) {
        guard (questionView.gestureRecognizers?.contains(sender) ?? false),
            (MDebug.shared.shouldDebug),
            (MDebug.shared.mods.contains(.infiniteQuestions)) else { return }
        
        _currentPlayer?.answerAllQuestions()
        refresh()
        
    }
    
    private func configureView() {
        
        view.addMillenialsGradient()
        
        updateNavItemTitle()
        
        self.questionView = UIView()
        self.questionLabel = UILabel()
        self.buttonStackView = UIStackView()
        
        while buttons.count != _currentQuestion?.answers.count {
            addBtn()
        }
        
        buttons.updateAnswers()
        updateViewBasedOnLayout()
    }
    
    @objc
    private func updateViewBasedOnLayout() {
        
        if (hasPerformedAnimation == false) {
            return configureVerticalConstraints()
        }
        
        UIDevice.current.orientation.isPortrait ? configureVerticalConstraints() : configureHorizontalConstraints()
        
    }
    
    @nonobjc
    private func configureVerticalConstraints() {
        questionView?.removeFromSuperview()
        questionLabel?.removeFromSuperview()
        buttonStackView?.removeFromSuperview()
        
        view.addSubview(questionView)
        questionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        questionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        questionView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        questionView?.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 30).isActive = true
        
        questionView.addSubview(questionLabel)
        questionLabel?.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
        questionLabel?.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
        questionLabel?.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
        questionLabel?.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        
        view.addSubview(buttonStackView)
        buttonStackView?.leadingAnchor.constraint(equalTo: questionView.leadingAnchor).isActive = true
        buttonStackView?.trailingAnchor.constraint(equalTo: questionView.trailingAnchor).isActive = true
        buttonStackView?.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 50).isActive = true
        buttonStackView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        buttonStackView?.arrangedSubviews.forEach() { view in
            view.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor).isActive = true
        }
        view.layoutIfNeeded()
    }
    
    @nonobjc
    private func configureHorizontalConstraints() {
        questionView?.removeFromSuperview()
        questionLabel?.removeFromSuperview()
        buttonStackView?.removeFromSuperview()
        
        view.addSubview(questionView)
        questionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        questionView?.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15).isActive = true
        questionView?.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 15).isActive = true
        questionView?.bottomAnchor.constraint(equalTo: view.safeGuide.bottomAnchor, constant: -15).isActive = true
        
        questionView.addSubview(questionLabel)
        questionLabel?.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
        questionLabel?.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
        questionLabel?.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
        questionLabel?.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        
        view.addSubview(buttonStackView)
        buttonStackView?.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
        buttonStackView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        buttonStackView?.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
        buttonStackView?.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        buttonStackView?.arrangedSubviews.forEach() { view in
            view.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor).isActive = true
        }
        view.layoutIfNeeded()
    }
    
    @nonobjc
    private func buttonFactory() -> UIButton {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(playerAnswered(_:)), for: .touchUpInside)
        btn.backgroundColor = .Purple
        btn.clipsToBounds = true
        btn.isExclusiveTouch = true 
        btn.layer.cornerRadius = 10
        btn.setTitle("", for: .normal)
        btn.setTitleColor(.OffWhite, for: .normal)
        btn.titleLabel?.font = .defaultFont(size: 18, weight: .medium)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 1
        return btn
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.noQuestionTimer) { return }
        
        guard hasPerformedAnimation else { return }
        if let barTimer = navigationItem.rightBarButtonItem as? BarTimer {
            barTimer.startTimer()
            hasStartedTimer = true
        }
        
    }
    
    func performSpecialAnimation() {
        guard (hasPerformedAnimation == false) else { return }
        configureView()
        
        var animationViews: [UIView] = [questionLabel, questionView]
        animationViews += buttons
        
        let animationViewsNS = NSArray(array: animationViews)
        animationViewsNS.enumerateObjects(options: .reverse) { (view, pos, stop) in
            let view = view as! UIView
            let time = 0.3*Double(pos)
            self.animateAlpha(view: view, delay: time)
            if (pos == animationViews.count - 1) {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) + .milliseconds(800)) {
                    self.hasPerformedAnimation = true
                    if let barTimer = self.navigationItem.rightBarButtonItem as? BarTimer {
                        barTimer.startTimer()
                        self.hasStartedTimer = true
                    }
                    OrientationManager.unlockPortrait()
                }
            }
        }
    }
    
    @nonobjc
    private func animateAlpha(view: UIView, delay: TimeInterval) {
        
        CATransaction.begin()
        CATransaction.disableActions()
        CATransaction.setAnimationDuration(0)
        view.layer.opacity = 0.0
        view.layer.transform = CATransform3DMakeTranslation(0, 60, 0)
        CATransaction.commit()
        
        UIView.animate(withDuration: 1.4, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.4, options: [.allowAnimatedContent, .allowUserInteraction, .curveEaseInOut], animations: {
            view.layer.opacity = 1.0
            view.layer.transform = CATransform3DIdentity
        })
        
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
        OrientationManager.lockPortrait()
        if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.noQuestionTimer) { return }
        shouldReset ? stopTimer() : freezeTimer()
    }
    
    @objc
    private func playerNotAnswered() {
        
        buttons.disableInteraction()
        noAnswer()
        
    }
    
    @objc
    private func playerAnswered(_ button: UIButton? = nil) {
        buttons.disableInteraction()
        
        if let timer = navigationItem.rightBarButtonItem as? BarTimer { timer.endTimer() }
        let playerAnswer = button?.title(for: .normal)
        if (_currentQuestion?.correctAnswer == playerAnswer) {
            correctAnswer(button!)
        } else {
            wrongAnswer(button!)
        }
        
    }
    
    func refresh() {
        
        _currentPlayer?.refreshCurrentQuestion()
        
        guard (_currentPlayer!.questions.count > 0) else {
            shouldReset = true
            return displayPlayerStats()
        }
        
        updateView()
        
    }
    
    private func updateView() { updateAnimation() }
    
    private func displayPlayerStats() { exitAnimation() }
    
    private func stopTimer() {
        guard (navigationItem.rightBarButtonItem != nil),
            let barTimer = navigationItem.rightBarButtonItem as? BarTimer else { return navigationItem.setRightBarButton(nil, animated: false) }
        
        barTimer.endTimer()
        navigationItem.setRightBarButton(nil, animated: true)
    }
    
    private func freezeTimer() {
        
        guard (navigationItem.rightBarButtonItem != nil),
            let barTimer = navigationItem.rightBarButtonItem as? BarTimer else { return }
        
        barTimer.freezeTimer()
        
    }

}

extension QuestionVC {
    
    func enterAnimation() { }
    
    func updateNavItemTitle() {
        
        let remainingQuestions = _currentPlayer!.questions.count
        let totalQuestions = Questions.shared.roundQuestions.count
        
        let fadeAnim = CATransition()
        fadeAnim.duration = 0.2
        fadeAnim.type = .fade
        
        navigationController?.navigationBar.layer.add(fadeAnim, forKey: "fadeText")
        navigationItem.title = localized("Question") + " \((totalQuestions + 1) - remainingQuestions)/\(totalQuestions)"
        
    }
    
    @discardableResult
    private func addBtn() -> UIButton {
        let btn = buttonFactory()
        btn.isExclusiveTouch = true
        buttons.append(btn)
        buttonStackView.addArrangedSubview(btn)
        btn.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor).isActive = true
        return btn
    }
    
    func updateAnimation() {
        
       updateNavItemTitle()
        
       UIView.animate(withDuration: 0.2, animations: {
        
        self.buttons.hideLabel()
        self.questionLabel.alpha = 0.0
        
       }, completion: {_ in
        
        for btn in self.buttons {
            btn.removeFromSuperview()
            self.buttons.removeFirst()
        }
        
        var count = 0
        while count != _currentQuestion?.answers.count {
            count++
            let newButton = self.addBtn()
            newButton.alpha = 0.0
            newButton.isUserInteractionEnabled = false 
        }
        
        self.buttons.updateAnswers()
        self.questionLabel.text = _currentQuestion!.statement
        
            UIView.animate(withDuration: 0.2, animations: {
                
                self.buttons.showLabel()
                self.questionLabel.alpha = 1.0
                
            }, completion: {_ in
                
                self.buttons.enableInteraction()
                
                guard (self.navigationItem.rightBarButtonItem != nil),
                      let timer = self.navigationItem.rightBarButtonItem as? BarTimer else { return }
                
                timer.startTimer()
                
            })
        
       })
        
    }
    
    func exitAnimation() {
        
        stopTimer()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.buttons.hide()
            self.questionView.alpha = 0.0
            
        }, completion: {_ in
            OrientationManager.lockPortrait()
            self.performSegue(withIdentifier: "QuestionStatsSegue", sender: nil)
            
        })
        
    }
    
    
}

extension QuestionVC {
    
    @nonobjc
    private func getAnswerOrder() -> [String] {
        var answers: [String] = []
        
        buttons.forEach() { btn in
            let answer = btn.title(for: .normal) ?? ""
            answers.append(answer)
        }
        
        return answers
    }
    
    @objc
    func noAnswer() {
        
        displayCorrectAnswer()
        
        _currentPlayer?.questionAnswered(order: getAnswerOrder())
        
        HapticFeedback.shared.warningFeedback()
        AudioFeedback.shared.noAnswerFeedback()
        
        waitAndRefresh()
        
    }
    
    @objc
    func wrongAnswer(_ btn: UIButton) {
        
        displayCorrectAnswer()
        btn.animateColor(final: .Red)
        
        _currentPlayer?.questionAnswered(answer: btn.title(for: .normal), order: getAnswerOrder())
        
        HapticFeedback.shared.errorFeedback()
        AudioFeedback.shared.errorFeedback()
        
        waitAndRefresh()
        
    }
    
    @objc
    func correctAnswer(_ btn: UIButton) {
        
        _currentPlayer?.questionAnswered(answer: _currentQuestion?.correctAnswer, order: getAnswerOrder())
        displayCorrectAnswer(btn)
        
        HapticFeedback.shared.sucessFeedback()
        AudioFeedback.shared.sucessFeedback()
        
        let index = buttons.firstIndex(of: btn)!
        let addedPointsView = AddedPointsView()
        
        if (index == 0) {
            addedPointsView.configure(with: view, btn)
        } else {
            addedPointsView.configure(with: view, btn, earlierButton: buttons[index - 1])
        }
        
        addedPointsView.display(completionHandler: { self.refresh() })
        
    }
    
    func displayCorrectAnswer(_ button: UIButton? = nil) {
        
        guard (button == nil) else { return button!.animateColor(final: .Green) }
        
        let correctAnswer = _currentQuestion?.correctAnswer
        let correctButton: UIButton? = buttons.first() { $0.title(for: .normal) == correctAnswer }
        correctButton?.animateColor(final: .Green)
        
    }
    
    func waitAndRefresh() { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { self.refresh() }) }
    
}

    // MARK: - Catalyst features
/*
@available(macCatalyst 13.0, *)
extension QuestionVC: NSTouchBarDelegate {
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        
        return touchBar
    }
    
}
*/
