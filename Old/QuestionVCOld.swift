//
//  QuestionVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 26/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class QuestionView: UIView { }

class QuestionVC: UIViewController {
    
    public var millenials: Millenials! {
        
        didSet {
            
            guard (self.millenials != nil) else { return }
            
            self.player = self.millenials.currentPlayer
            
        }
        
    }
    
    private var player: Player?
    
    private var viewHasLoaded: Bool! = false {
        
        didSet {
            
            //if (millenials != nil) {
                
                nextQuestion()
                
            //}
            
        }
        
    }
    
    private var questionView: QuestionView!
    
    private var questionLabel: UILabel!
    
    private var buttons: [UIButton] = [UIButton(), UIButton(), UIButton(), UIButton()]
    private var buttonConstraints: [[NSLayoutConstraint]] = []
    
    private var question: String!
    private var rightAnswer: String!
    
    private var answers: [String]! {
        
        didSet {
            
            self.answers = self.answers.shuffled()
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        addObservers()
        
        // Do any additional setup after loading the view.
    }
    
    private func configureView() {
        
        view.backgroundColor = .LightMidnightBlue
        
        questionView = QuestionView()
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.layer.cornerRadius = 10.0
        questionView.clipsToBounds = true
        questionView.backgroundColor = .OffWhite
        
        view.addSubview(questionView)
        
        questionLabel = UILabel()
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.font = UIFont.defaultFont(size: 20, weight: .regular)
        questionLabel.backgroundColor = .OffWhite
        questionLabel.textColor = .OffBlack
        
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        
        questionView.addSubview(questionLabel)
        
        questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
        
        questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        
        
        questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        
        if let navBar = navigationController?.navigationBar {
                
           questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (navBar.bounds.height + 80)).isActive = true
            
        } else {
            
            questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true 
            
        }
      
        
        questionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        
        buttons = buttons.map({(button) in
            
            button.addTarget(self, action: #selector(self.inputAnswer(_:)), for: .touchUpInside)
            
            button.layer.cornerRadius = 10.0
            button.clipsToBounds = true
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isExclusiveTouch = true
            
            button.titleLabel?.font = UIFont.defaultFont(size: 18, weight: .medium)
            button.setTitleColor(.OffWhite, for: .normal)
            button.backgroundColor = .MidnightBlue
            
            view.addSubview(button)
            
            let index = buttons.firstIndex(of: button)!
            
            if (index == 0) {
                
                button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
                
            } else {
                
                let earlierButton = buttons[index - 1]
                
                button.topAnchor.constraint(equalTo: earlierButton.bottomAnchor, constant: 25).isActive = true
                button.heightAnchor.constraint(equalTo: earlierButton.heightAnchor).isActive = true
                
                if (button == buttons.last!) {
                    
                    button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
                    
                }
            }
            
            let leading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -button.frame.width)
            let trailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width)
            
            leading.isActive = true
            trailing.isActive = true
            
            buttonConstraints.append([leading, trailing])
            
            return button
            
        })
        
        view.layoutIfNeeded()
        
        self.viewHasLoaded = true
        
        
    }
    
    private func updateView() {
        
        func animateView(completion: @escaping (() -> ())) {
            
            if (buttonConstraints.allSatisfy({($0.allSatisfy({(fabsf(Float($0.constant)) == 30)}))})) {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                   _ = self.buttons.map({(button) -> Button in
                        
                        button.titleLabel?.alpha = 0.0
                        
                        return button
                        
                    })                    
                    
                    self.questionLabel.alpha = 0.0
                    
                }, completion: {[unowned self](completed) in
                    
                    _ = self.buttons.map({(button) -> Button in
                        
                        button.setTitle(self.answers[self.buttons.firstIndex(of: button)!], for: .normal)
                        
                        return button
                        
                    })
                    
                    self.questionLabel.text = self.question
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        
                        _ = self.buttons.map({(button) -> Button in
                            
                            button.titleLabel?.alpha = 1.0
                            
                            return button
                            
                        })
                        
                        self.questionLabel.alpha = 1.0
                        
                    }, completion: {(completed) in
                        
                        completion()
                        
                    })
                    
                
                })
                
                return
                
            }
            
            _ = buttonConstraints.map({(constraint) -> [NSLayoutConstraint] in
                
                constraint.first!.constant = 30
                constraint.last!.constant = -30
                
                buttons[buttonConstraints.firstIndex(of: constraint)!].layoutIfNeeded()
                
                return constraint
                
            })
           
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: {(completed) in
                
                completion()
                
            })
            
            _ = self.buttons.map({(button) -> Button in
                
                button.setTitle(answers[buttons.firstIndex(of: button)!], for: .normal)
                
                return button
                
            })
            
            questionLabel.text = question
            
            }
        
        navigationItem.title = "Questão \(6 - millenials.currentPlayer.questionsToAnswer.count)/\(5)"
        
        animateView(completion: {
            
            _ = self.buttons.map({(button) -> Button in
                
                button.isUserInteractionEnabled = true
                
                return button
                
            })
            
            guard (self.navigationItem.rightBarButtonItem != nil),
                let timer = self.navigationItem.rightBarButtonItem as? BarTimer else { return }
            
                timer.startTimer()
            
        })
        
    }
    
    
    @objc
    private func nextQuestion() {
        
        guard (millenials?.currentPlayer! == player!),
            (millenials?.currentPlayer.questionsToAnswer != nil),
            ((millenials?.currentPlayer.questionsToAnswer.indices.contains(0))!),
              let questionObject = millenials?.currentPlayer.questionsToAnswer[0] else { return }
        
        question = questionObject.question
        rightAnswer = questionObject.rightAnswer
        answers = questionObject.wrongAnswers + [rightAnswer]
        
        updateView()
        
    }
  
    @objc
    private func inputAnswer(_ buttonPressed: Button) {
        
        _ = buttons.map({(button) -> Button in
            
            button.isUserInteractionEnabled = false
            
            return button
            
        })
        
        if let timer = navigationItem.rightBarButtonItem as? BarTimer {
            
            timer.endTimer()
            
        }
        
        
        // partimos para a próxima questão,
        // com um pequeno delay
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
        
        guard (buttonPressed.title(for: .normal) == rightAnswer) else {
            
            incorrectAnswer(button: buttonPressed)
            
            if #available(iOS 10.0, *) { HapticFeedback.shared.errorFeedback() } else {}
            
            return
            
        }
         
            correctAnswer(button: buttonPressed)
            
            if #available(iOS 10.0, *) { HapticFeedback.shared.sucessFeedback() } else {}
    }
    
    @objc
    private func noAnswer() {
        
        _ = buttons.map({(button) -> Button in
            
            button.isUserInteractionEnabled = false
            
            return button
            
        })
        
        // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredIncorrectly")
            
        }
        
        // partimos para a próxima questão,
        // com um pequeno delay
        
       _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
        
        // feedback físico
        
            if #available(iOS 10.0, *) { HapticFeedback.shared.warningFeedback() } else {}
        
        // mostramos a resposta certa com
        // feedback visual
        
        displayCorrectAnswer()
        
    }
    
    
    private func correctAnswer(button: Button) {
        
        func displayPoints() {
            
            let pointsView = UIView()
                pointsView.clipsToBounds = true
            
                pointsView.backgroundColor = view.backgroundColor
            
                view.addSubview(pointsView)
            
                pointsView.translatesAutoresizingMaskIntoConstraints = false
            
                pointsView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
                pointsView.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
            
            if (button != buttons.first!) {
                
                pointsView.topAnchor.constraint(equalTo: buttons[buttons.firstIndex(of: button)! - 1].bottomAnchor).isActive = true
                
            } else {
                
                pointsView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 25).isActive = true
                
            }
            
            
            
            let pointsLabel = UILabel()
                pointsLabel.translatesAutoresizingMaskIntoConstraints = false
                pointsLabel.clipsToBounds = true
                pointsLabel.backgroundColor = view.backgroundColor
            
            var top: NSLayoutConstraint!
            var bottom: NSLayoutConstraint!
            
            func animate() {
                
                top.constant = 0
                bottom.constant = 0
                
                UILabel.animate(withDuration: 0.3, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                    
                    pointsView.layoutIfNeeded()
                    
                }, completion: {(completed) in
                    
                    top.constant = -pointsView.frame.height
                    bottom.constant = -pointsView.frame.height
                    
                    UILabel.animate(withDuration: 0.3, delay: 0.1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                        
                        pointsView.layoutIfNeeded()
                        
                    }, completion: {(completed) in
                        
                        pointsView.removeFromSuperview()
                        
                    })
                    
                    
                })
                
            }
            
                pointsLabel.text = "+\(player!.plusPoints)"
                pointsLabel.textColor = .Green
            
                pointsLabel.font = UIFont.defaultFont(size: 15, weight: .medium)
            
                pointsView.addSubview(pointsLabel)
            
                pointsView.layoutIfNeeded()
            
                pointsLabel.leadingAnchor.constraint(equalTo: pointsView.leadingAnchor).isActive = true
                pointsLabel.trailingAnchor.constraint(equalTo: pointsView.trailingAnchor).isActive = true
            
                top = pointsLabel.topAnchor.constraint(equalTo: pointsView.topAnchor, constant: pointsView.frame.height)
                top.isActive = true
            
                bottom = pointsLabel.bottomAnchor.constraint(equalTo: pointsView.bottomAnchor, constant: pointsView.frame.height)
                bottom.isActive = true
            
                pointsView.layoutIfNeeded()
            
                animate()
            
        }
        
            // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredCorrectly")
            displayPoints()
            
        }
        
            // mudamos o visual do botão
        
        button.backgroundColor = .Green
        
        
      
    }

    private func incorrectAnswer(button: Button) {
        
        // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredIncorrectly", data: ["answer": button.title(for: .normal)!])
            
        }
        
        
        // mudamos o visual do botão pressionado
        
        button.backgroundColor = .Red
        
        // mudamos o visual do botão com a
        // resposta certa
        
        displayCorrectAnswer()
       
        
    }
    
    private func displayCorrectAnswer() {
        
        let correctButton: Button! = buttons.first(where: {$0.title(for: .normal) == rightAnswer})
        
        guard (correctButton != nil) else { return }
        
        correctButton.backgroundColor = .Green
        
    }
    
    @objc
    private func endPlayerRound() {
        
        func end() {
            
            performSegue(withIdentifier: "QuestionPlayerUnwind", sender: millenials)
            
        }
        
        navigationItem.setRightBarButton(nil, animated: true)
        
        
          let alert = UIAlertController(title: "Alerta", message: "Sua jogada acabou!", preferredStyle: .alert)
        
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                
                end()
                
            })
        
            alert.addAction(ok)
        
            present(alert, animated: true, completion: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "QuestionPlayerUnwind") {
            
            let rootVC = segue.destination as! PlayerChangeVC
            rootVC.millenials = millenials
            
        }
        
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(endPlayerRound), name: notification(name: "PlayerHasFinished"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(noAnswer), name: notification(name: "PlayerDidNotAnswerInTime"), object: nil)
        
    }
    
    private func removeObservers() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
        
    }
    
    deinit {
        removeObservers()
        
        
    }

}
