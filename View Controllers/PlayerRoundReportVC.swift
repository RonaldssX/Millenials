//
//  PlayerRoundReportVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit    // StatsChangeSegue

class PlayerRoundReportVC: UIViewController {   
    
    private var imageViewConstraint: NSLayoutConstraint? // 50 \ 30
    private var playerImageView: UIImageView! {
        
        didSet {
            
            guard (self.playerImageView != nil) else { return }
            
            self.playerImageView.alpha = 0.0
            
            self.playerImageView.contentMode = .scaleAspectFill
            
            self.playerImageView.tintColor = .OffWhite
            
            self.playerImageView.backgroundColor = _currentPlayer?.color
                        
            self.playerImageView.isUserInteractionEnabled = false
            
            view.addSubview(self.playerImageView)
            
            self.playerImageView.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
                self.playerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
                self.playerImageView.heightAnchor.constraint(equalTo: view.safeGuide.widthAnchor, multiplier: 1/3).isActive = true
                
                
            } else {
            
                self.playerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
                self.playerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
                
            }
            
            imageViewConstraint = self.playerImageView.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: view.bounds.height)
            imageViewConstraint!.isActive = true
            
            self.playerImageView.widthAnchor.constraint(equalTo: self.playerImageView.heightAnchor).isActive = true
            
            self.playerImageView.layer.borderWidth = 7
            self.playerImageView.layer.borderColor = UIColor.OffWhite.cgColor
            self.playerImageView.layer.masksToBounds = true 
            
            self.playerImageView.rounded()
            
            self.playerImageView.image = _currentPlayer?.picture
            
            if (self.playerImageView.image == PlayerPictures.shared.defaultAdd || self.playerImageView.image == PlayerPictures.shared.defaultGame) {
                
                self.playerImageView.image = self.playerImageView.image?.withRenderingMode(.alwaysTemplate)
                
            }
            
        }
        
    }
    
    private var playerStatsView: PlayerStatsView! {
        
        didSet {
            
            guard (self.playerStatsView != nil) else { return }
            
            self.playerStatsView.alpha = 0.0
            
            self.playerStatsView.style = .Light // colors
            self.playerStatsView.size = .Small
            self.playerStatsView.configure(with: self) // width constraints
            
            self.playerStatsView.layer.cornerRadius = 10
            
        }
        
    }
    
    private var tableViewConstraint: NSLayoutConstraint?    // 30
    private var roundQuestionsReportTableView: UITableView! {
        
        didSet {
            
            guard (self.roundQuestionsReportTableView != nil) else { return }
            
            self.roundQuestionsReportTableView.alpha = 0.0
            
            self.roundQuestionsReportTableView.backgroundColor = .clear
            
            self.roundQuestionsReportTableView.translatesAutoresizingMaskIntoConstraints = false
            
            self.roundQuestionsReportTableView.rowHeight = 120
            
            self.roundQuestionsReportTableView.layer.cornerRadius = 12
            self.roundQuestionsReportTableView.clipsToBounds = true
            
            self.roundQuestionsReportTableView.showsVerticalScrollIndicator = false
            self.roundQuestionsReportTableView.showsHorizontalScrollIndicator = false
            
            self.roundQuestionsReportTableView.alwaysBounceVertical = false
            self.roundQuestionsReportTableView.alwaysBounceHorizontal = false
            self.roundQuestionsReportTableView.bounces = false
            
            self.roundQuestionsReportTableView.dataSource = self
            
            self.roundQuestionsReportTableView.register(QuestionReportCell.self, forCellReuseIdentifier: "QuestionCell")
            
            view.addSubview(self.roundQuestionsReportTableView)
            
            self.roundQuestionsReportTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (isiPad ? 60 : 10)).isActive = true
            self.roundQuestionsReportTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (isiPad ? -60 : -10)).isActive = true
            
            tableViewConstraint = self.roundQuestionsReportTableView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height)
            tableViewConstraint!.isActive = true
            
            self.roundQuestionsReportTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -50).isActive = true
            
        }
        
    }
    
    private var buttonConstraint: NSLayoutConstraint?   // -30
    public var continueButton: UIButton! {
        
        didSet {
            
            guard (self.continueButton != nil) else { return }
            
            self.continueButton.alpha = 0.0
            
            self.continueButton.addTarget(self, action: #selector(continueToNextPlayer), for: .touchUpInside)
            
            self.continueButton.backgroundColor = .Pink
            
            self.continueButton.layer.cornerRadius = 20
            self.continueButton.clipsToBounds = true
            
            self.continueButton.setTitle("Continuar", for: .normal)
            self.continueButton.setTitleColor(.OffWhite, for: .normal)
            self.continueButton.titleLabel?.font = UIFont.defaultFont(size: 20, weight: .regular)
            
            view.addSubview(self.continueButton)
            
            self.continueButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
            self.continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
            
            buttonConstraint = self.continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.bounds.height)
            buttonConstraint!.isActive = true
            
            self.continueButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateDisplay()
        
    }
    
    private func configureView() {        
        
        view.addMillenialsGradient()
        
        self.playerStatsView = PlayerStatsView()
        
        self.playerImageView = UIImageView()        
        
        self.playerStatsView.centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor).isActive = true
        
        self.continueButton = UIButton()
        
        self.roundQuestionsReportTableView = UITableView()
    }
    
    @objc
    private func continueToNextPlayer() {
        
        Millenials.shared.playerFinished()        
        
        guard !(Millenials.shared.gameHasEnded) else { return animateExit() }
        
        performSegue(withIdentifier: "StatsChangeSegue", sender: nil)
    }

}

extension PlayerRoundReportVC {
    
    private func animateDisplay() {
        
        imageViewConstraint?.constant = (isiPad ? 90 : 30)
        UIImageView.animate(withDuration: 0.4, delay: 0.2, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.playerImageView.alpha = 1.0
            self.playerStatsView.alpha = 1.0
            self.view.layoutIfNeeded()
            
        }, completion: {[weak self]_ in
            
            self?.tableViewConstraint?.constant = 30
            UITableView.animate(withDuration: 0.4, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self?.roundQuestionsReportTableView.alpha = 1.0
                self?.view.layoutIfNeeded()
                
            }, completion: {[weak self]_ in
                
                self?.buttonConstraint?.constant = -30
                UIButton.animate(withDuration: 0.4, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                    
                    self?.continueButton.alpha = 1.0
                    self?.view.layoutIfNeeded()
                    
                }, completion: nil)
                
            })            
            
        })
        
    }
    
    private func animateExit() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.playerImageView.alpha = 0.0
            self.playerStatsView.alpha = 0.0
            
            self.roundQuestionsReportTableView.alpha = 0.0
            self.continueButton.alpha = 0.0
            
        }, completion: {_ in
            
            self.performSegue(withIdentifier: "ReportConclusionSegue", sender: nil)
            
        })
        
    }
    
}

extension PlayerRoundReportVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return Questions.shared.roundQuestions.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let questionCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionReportCell
        
        if (Millenials.shared.gameRound == 1) {
            
            questionCell.configureWithQuestion((_currentPlayer?.answeredQuestions[indexPath.row])!)
            
        } else if (Millenials.shared.gameRound == 2) {
                
            questionCell.configureWithQuestion((_currentPlayer?.answeredQuestions[indexPath.row + 5])!)
                
        } else {
                    
            questionCell.configureWithQuestion((_currentPlayer?.answeredQuestions[indexPath.row + 10])!)
                    
        }
        
        return questionCell
        
    }
    
    
    
}

