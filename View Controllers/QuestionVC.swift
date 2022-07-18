//
//  QuestionVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 26/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    
    public var millenials: Millenials!
    
    private var viewHasLoaded: Bool! = false {
        
        didSet {
            
            if (millenials != nil) {
                
                nextQuestion()
                
            }
            
        }
        
    }
    
    
    private var questionView: UIView!
    
    private var questionLabel: UILabel!
    
    private var answer1Button: UIButton!
    private var answer1ButtonConstraint: [NSLayoutConstraint] = [] {
        
        didSet {
            
            for constraint in self.answer1ButtonConstraint {
                
                constraint.isActive = true
                answer1Button.layoutIfNeeded()
                
            }
            
        }
        
    }
    
    private var answer2Button: UIButton!
    private var answer2ButtonConstraint: [NSLayoutConstraint] = [] {
            
        didSet {
            
        for constraint in self.answer2ButtonConstraint {
            
            constraint.isActive = true
            answer2Button.layoutIfNeeded()
            
            }
            
       }
            
    }
    
    private var answer3Button: UIButton!
    private var answer3ButtonConstraint: [NSLayoutConstraint] = [] {
                
        didSet {
            
        for constraint in self.answer3ButtonConstraint {
            
            constraint.isActive = true
            answer3Button.layoutIfNeeded()
            
            }
            
       }
                
    }
    
    private var answer4Button: UIButton!
    private var answer4ButtonConstraint: [NSLayoutConstraint] = [] {
                    
        didSet {
            
        for constraint in self.answer4ButtonConstraint {
            
            constraint.isActive = true
            answer4Button.layoutIfNeeded()
            
            }
            
       }
                    
    }
    
    
    private var buttons: [UIButton] = []
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
        
        view.backgroundColor = UIColor.View.Background.questionVCColor
        
        questionView = UIView()
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.layer.cornerRadius = 10.0
        questionView.clipsToBounds = true
        
        questionView.backgroundColor = UIColor.View.Background.questionColor
        
        view.addSubview(questionView)
        
        questionLabel = UILabel()
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        
        questionLabel.textColor = UIColor.Text.questionTextColor
        
        questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        
        if let navBar = navigationController?.navigationBar {
                
           questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: (navBar.bounds.height + 80)).isActive = true
            
        } else {
            
            questionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true 
            
        }
      
        
        questionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        
        view.layoutIfNeeded()
        
        answer1Button = UIButton()
        answer2Button = UIButton()
        answer3Button = UIButton()
        answer4Button = UIButton()
        
        buttons = [answer1Button, answer2Button, answer3Button, answer4Button]
        
        
        for button in buttons {
            
            button.addTarget(self, action: #selector(self.inputAnswer(_:)), for: .touchUpInside)
            
            button.layer.cornerRadius = 10.0
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isExclusiveTouch = true
            
            button.setTitleColor(UIColor.Text.answersTextColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
            view.addSubview(button)
            
            
            let index = buttons.firstIndex(of: button)!
            
            if (index == 0) {
                
            button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
                
            } else {
            
            let earlierButton = buttons[index - 1]
            
            button.topAnchor.constraint(equalTo: earlierButton.bottomAnchor, constant: 25).isActive = true
            button.heightAnchor.constraint(equalTo: earlierButton.heightAnchor).isActive = true
            
            if (button == buttons.last ?? answer4Button) {
                
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
                
            }
          }
            
            let leading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -button.frame.width)
            let trailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width)
            
            
            if (button == answer1Button) {
                
                answer1ButtonConstraint = [leading, trailing]
                buttonConstraints.append(answer1ButtonConstraint)
                
                continue
                
            }
            
            if (button == answer2Button) {
                
                answer2ButtonConstraint = [leading, trailing]
                buttonConstraints.append(answer2ButtonConstraint)
                
                continue
                
            }
            
            if (button == answer3Button) {
                
                answer3ButtonConstraint = [leading, trailing]
                buttonConstraints.append(answer3ButtonConstraint)
                
                continue
                
            }
            
                answer4ButtonConstraint = [leading, trailing]
                buttonConstraints.append(answer4ButtonConstraint)
            
        }
        
        
        viewHasLoaded.toggle()
        
        
    }
    
    private func updateView() {
        
        func animateView(completion: @escaping (() -> ())) {
            
            if (buttonConstraints.allSatisfy({($0.allSatisfy({(fabsf(Float($0.constant)) == 30)}))})) {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    for button in self.buttons {
                     
                        button.titleLabel?.alpha = 0.0
                        
                    }
                    
                    self.questionLabel.alpha = 0.0
                        
                    
                }, completion: {(completed) in
                    
                    for button in self.buttons {
                        
                        button.setTitle(self.answers[self.buttons.firstIndex(of: button)!], for: .normal)
                        
                    }
                    
                    self.questionLabel.text = self.question
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        
                        for button in self.buttons {
                            
                            button.titleLabel?.alpha = 1.0
                            
                        }
                        
                        self.questionLabel.alpha = 1.0
                        
                    }, completion: {(completed) in
                        
                        completion()
                        
                    })
                    
                
                })
                
                return
                
            }
            
            questionLabel.text = question
            
            
            for button in buttons {
                
                button.setTitle(answers[buttons.firstIndex(of: button)!], for: .normal)
                
                let constraints = buttonConstraints[buttons.firstIndex(of: button)!]
                
                    constraints[0].constant = 30
                    constraints[1].constant = -30
                
                    UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                        
                        self.view.layoutIfNeeded()
                        
                    }, completion: {(completed) in
                        
                        completion()
                        
                    })
                
                
            }
            
            
            
            }
        
        navigationItem.title = "Questão \(6 - millenials.currentPlayer.questionsToAnswer.count)/\(5)"
       
        questionLabel.removeFromSuperview()
        
        questionView.addSubview(questionLabel)
        
        questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: 15).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -15).isActive = true
        questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor).isActive = true
        
        for button in buttons {
            
            button.backgroundColor = UIColor.View.Background.answersColor
            
        }
        
        animateView(completion: {
            
            guard (self.navigationItem.rightBarButtonItem != nil),
                let timer = self.navigationItem.rightBarButtonItem as? BarTimer else { return }
            
                timer.startTimer()
            
            for button in self.buttons {
                
                button.isUserInteractionEnabled = true
                
            }
            
            
        })
        
    }
    
    
    @objc
    private func nextQuestion() {
        
        
        let questionObject = millenials.currentPlayer.questionsToAnswer[0]
        
        question = questionObject.question
        rightAnswer = questionObject.rightAnswer
        answers = questionObject.wrongAnswers + [rightAnswer]
        
        updateView()
        
    }
    
  
    @objc
    private func inputAnswer(_ buttonPressed: UIButton) {
        
        for button in buttons {
            
            button.isUserInteractionEnabled = false
            
        }
        
        
        // partimos para a próxima questão,
        // com um pequeno delay
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
        
        
        let hapticFeedback = UINotificationFeedbackGenerator()
        
        
        if (buttonPressed.title(for: .normal) == rightAnswer) {
         
            correctAnswer(button: buttonPressed)
            
            hapticFeedback.notificationOccurred(.success)
            
            return
            
        }
        
          incorrectAnswer(button: buttonPressed)
        
            hapticFeedback.notificationOccurred(.error)
        
    }
    
    @objc
    private func noAnswer() {
        
        for button in buttons {
            
            button.isUserInteractionEnabled = false
            
        }
        
        // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredIncorrectly")
            
        }
        
        // partimos para a próxima questão,
        // com um pequeno delay
        
       _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nextQuestion), userInfo: nil, repeats: false)
        
        
        let incorrectFeedback = UINotificationFeedbackGenerator()
        
        // feedback físico
        
            incorrectFeedback.notificationOccurred(.warning)
        
        
        // mostramos a resposta certa com
        // feedback visual
        
        displayCorrectAnswer()
        
    }
    
    
    private func correctAnswer(button: UIButton) {
        
            // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredCorrectly")
            
        }
        
            // mudamos o visual do botão
        
        button.backgroundColor = UIColor.Feedback.correctAnswerColor
        
      
    }

    private func incorrectAnswer(button: UIButton) {
        
        // avisamos ao objeto do jogador
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.post(name: "PlayerAnsweredIncorrectly", data: ["answer": button.title(for: .normal)!])
            
        }
        
        
        // mudamos o visual do botão pressionado
        
        button.backgroundColor = UIColor.Feedback.incorrectAnswerColor
        
        // mudamos o visual do botão com a
        // resposta certa
        
        displayCorrectAnswer()
       
        
    }
    
    private func displayCorrectAnswer() {
        
        var correctButton: UIButton!
        
        for button in buttons {
            
            guard (button.title(for: .normal) != rightAnswer) else {
                
                correctButton = button
                return
                
            }
           
            
        }
        
        
        correctButton.backgroundColor = UIColor.Feedback.correctAnswerColor
        
        
    }
    
    @objc
    private func endPlayerRound() {        
        
          performSegue(withIdentifier: "QuestionPlayerUnwind", sender: millenials)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "QuestionPlayerUnwind") {
            
            let rootVC = segue.destination as! PlayerChangeVC
            rootVC.millenials = sender as! Millenials
            
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
        
        print("QuestionVC dealloc called.")
        
    }

}
