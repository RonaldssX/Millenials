//
//  AnsweredQuestionPreviewVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 12/11/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
#if targetEnvironment(macCatalyst)
import AppKit
#endif

final class AnsweredQuestionPreviewVC: UIViewController {
    
    private weak var question: Question?
    private weak var answeredQuestion: AnsweredQuestion?
    
    private var questionConstraint: NSLayoutConstraint?
    private var questionView: UIView! {
        
        didSet {
            
            guard (self.questionView != nil) else { return }
            
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
            
            questionConstraint = self.questionView.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: 30)
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
            
            self.questionLabel.text = question?.statement
            self.questionLabel.font = UIFont.defaultFont(size: 20, weight: .medium)
            
            questionView.addSubview(self.questionLabel)
            self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
            self.questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
            
            self.questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
            self.questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
            
        }
        
    }
    private var buttonStackView: UIStackView! {
        
        willSet { self.buttonStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.buttonStackView != nil) else { return }
            
            self.buttonStackView.alignment = .center
            self.buttonStackView.axis = .vertical
            self.buttonStackView.distribution = .fillEqually
            self.buttonStackView.spacing = 25
            
            view.addSubview(self.buttonStackView)
            self.buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            self.buttonStackView.leadingAnchor.constraint(equalTo: questionView.leadingAnchor).isActive = true
            self.buttonStackView.trailingAnchor.constraint(equalTo: questionView.trailingAnchor).isActive = true
            self.buttonStackView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 50).isActive = true
            self.buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
            
        }
        
    }
    
    func previewQuestion(_ quest: AnsweredQuestion, question: Question) {
        loadViewIfNeeded()
        
        if #available(iOS 13.0, *) {
            modalPresentationStyle = .automatic
        }
        
        self.answeredQuestion = quest
        self.question = question
        
        view.addMillenialsGradient()
        self.questionView = UIView()
        self.questionLabel = UILabel()
        self.buttonStackView = UIStackView()
        var answers: [String]
        if let order = quest.extraData["order"] as? [String] {
            answers = order
        } else {
            answers = question.answers
        }
        
        for answer in answers {
            let button = buttonFactory()
            button.layoutIfNeeded()
            button.setTitle(answer, for: .normal)
            if answer == quest.playerAnswer {
                button.backgroundColor = quest.answeredCorrectly ? .Green : .Red
                button.tag = 21
            } else if (!quest.hasAnswered && answer == question.correctAnswer) {
                button.backgroundColor = .blue
            } else {
                button.backgroundColor = .LightPurple
            }
            buttonStackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor).isActive = true
        }
        view.layoutIfNeeded()
    }
    
    @nonobjc
    private func buttonFactory() -> UIButton {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(.OffWhite, for: .normal)
        btn.titleLabel?.font = .defaultFont(size: 18, weight: .medium)
        return btn
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }
        
        buttonStackView.arrangedSubviews.forEach() { view in
            if (view.tag != 21) {
                UIView.animate(withDuration: 0.1, delay: 0, options: [.preferredFramesPerSecond60, .curveLinear, .allowUserInteraction], animations: {
                    
                    view.backgroundColor = .Purple
                    view.layoutIfNeeded()
                    
                })
            }
        }
        
    }
    
}

extension AnsweredQuestionPreviewVC {
    
    func updateNavItemTitle() {
        
        let remainingQuestions = _currentPlayer!.questions.count
        let totalQuestions = Questions.shared.roundQuestions.count
        
        let fadeAnim = CATransition()
        fadeAnim.duration = 0.2
        fadeAnim.type = .fade
        
        navigationController?.navigationBar.layer.add(fadeAnim, forKey: "fadeText")
        navigationItem.title = localized("Question") + " \((totalQuestions + 1) - remainingQuestions)/\(totalQuestions)"
        
    }
    
    func exitAnimation() {
        
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
