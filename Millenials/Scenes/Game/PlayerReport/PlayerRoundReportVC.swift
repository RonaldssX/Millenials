//
//  PlayerRoundReportVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit    // StatsChangeSegue

final class PlayerRoundReportVC: UIViewController {
    
    weak var player: Player?
    weak var coordinator: GameSceneCoordinator?
    
    private var imageViewConstraint: NSLayoutConstraint? // 50 \ 30
    private var playerImageView: UIImageView! {
        
        willSet { self.playerImageView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.playerImageView != nil) else { return }
            
            self.playerImageView.alpha = 0.0
            self.playerImageView.backgroundColor = player?.color
            self.playerImageView.contentMode = .scaleAspectFill
            self.playerImageView.image = player?.picture
            self.playerImageView.isUserInteractionEnabled = false
            self.playerImageView.layer.borderWidth = 7
            self.playerImageView.layer.borderColor = UIColor.OffWhite.cgColor
            self.playerImageView.layer.masksToBounds = true
            self.playerImageView.tintColor = .OffWhite
                        
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
            
            self.playerImageView.rounded()
            if (PlayerPictures.isDefaultPicture(playerImageView.image)) {
                self.playerImageView.image = self.playerImageView.image?.withRenderingMode(.alwaysTemplate)
            }
            /*
            if let c = playerStatsView.pointStackView.constraints.first(where: { $0.identifier == "leading" }) {
                playerStatsView.pointStackView.removeConstraint(c)
                playerStatsView.pointStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.playerImageView.leadingAnchor, constant: -5).isActive = true
            }
            
            if let c = playerStatsView.roundStackView.constraints.first(where: { $0.identifier == "trailing" }) {
                playerStatsView.roundStackView.removeConstraint(c)
                playerStatsView.roundStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.playerImageView.trailingAnchor, constant: 5).isActive = true 
            }
            */
        }
        
    }
    
    private var playerStatsView: PlayerStatsView! {
        
        willSet { self.playerStatsView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.playerStatsView != nil) else { return }
            
            self.playerStatsView.alpha = 0.0
            
            let style = PlayerStatusViewStyles(colors: .light, sizes: .small)
            self.playerStatsView.configure(with: player!, viewStyle: style)
            self.playerStatsView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self.playerStatsView)
            NSLayoutConstraint.activate([
                self.playerStatsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.playerStatsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            self.playerStatsView.layer.cornerRadius = 10
            
        }
        
    }
    
    private var tableViewConstraint: NSLayoutConstraint?    // 30
    private var roundQuestionsReportTableView: UITableView! {
        
        willSet { self.roundQuestionsReportTableView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.roundQuestionsReportTableView != nil) else { return }
            
            self.roundQuestionsReportTableView.alpha = 0.0
            self.roundQuestionsReportTableView.alwaysBounceHorizontal = false
            self.roundQuestionsReportTableView.alwaysBounceVertical = false
            self.roundQuestionsReportTableView.backgroundColor = .clear
            self.roundQuestionsReportTableView.bounces = false
            self.roundQuestionsReportTableView.clipsToBounds = true
            self.roundQuestionsReportTableView.dataSource = self
            self.roundQuestionsReportTableView.delegate = self
            self.roundQuestionsReportTableView.layer.cornerRadius = 12
            self.roundQuestionsReportTableView.register(QuestionReportCell.self, forCellReuseIdentifier: "QuestionCell")
            self.roundQuestionsReportTableView.rowHeight = UITableView.automaticDimension
            self.roundQuestionsReportTableView.showsHorizontalScrollIndicator = false
            self.roundQuestionsReportTableView.showsVerticalScrollIndicator = false
            
            view.addSubview(self.roundQuestionsReportTableView)
            self.roundQuestionsReportTableView.translatesAutoresizingMaskIntoConstraints = false
            
            self.roundQuestionsReportTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (isiPad ? 60 : 10)).isActive = true
            self.roundQuestionsReportTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (isiPad ? -60 : -10)).isActive = true
            
            tableViewConstraint = self.roundQuestionsReportTableView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height)
            tableViewConstraint?.isActive = true
            
            self.roundQuestionsReportTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -50).isActive = true
            
        }
        
    }
    
    private var buttonConstraint: NSLayoutConstraint?   // -30
    var continueButton: UIButton! {
        
        willSet { self.continueButton?.removeFromSuperview() }
        
        didSet {
            
            guard (self.continueButton != nil) else { return }
            
            self.continueButton.alpha = 0.0
            self.continueButton.addTarget(self, action: #selector(continueToNextPlayer), for: .touchUpInside)
            self.continueButton.backgroundColor = .Pink
            self.continueButton.clipsToBounds = true
            self.continueButton.layer.cornerRadius = 20
            self.continueButton.setTitle(localized("Continue"), for: .normal)
            self.continueButton.setTitleColor(.OffWhite, for: .normal)
            self.continueButton.titleLabel?.font = .defaultFont(size: 20, weight: .regular)
            
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
        
        self.loadViewIfNeeded()
        animateDisplay()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }
        
        playerImageView.layer.cornerRadius = playerImageView.frame.width / 2
        
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
        if (GameConfigs.shared.tempShouldUseSegues) {
            performSegue(withIdentifier: "StatsChangeSegue", sender: nil)
        } else {
            coordinator?.goToPlayerChange()
            /*
            if let playerChangeVC = navigationController?.children.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC {
                playerChangeVC.configure(with: Millenials.shared.currentPlayer!)
                navigationController?.popToViewController(playerChangeVC, animated: false)
            } else {
                let playerChangeVC = PlayerChangeVC()
                playerChangeVC.configure(with: Millenials.shared.currentPlayer!)
                navigationController?.pushViewController(playerChangeVC, animated: false)
            }
             */
        }

    }

}

extension PlayerRoundReportVC {
    
    private func animateDisplay() {
        
        imageViewConstraint?.constant = (isiPad ? 90 : 30)
        UIImageView.animate(withDuration: 0.4, delay: 0.2, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
            
            self.playerImageView?.alpha = 1.0
            self.playerStatsView?.alpha = 1.0
            self.view.layoutIfNeeded()
            
        }, completion: {_ in
            
            self.tableViewConstraint?.constant = 30
            UITableView.animate(withDuration: 0.4, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                
                self.roundQuestionsReportTableView?.alpha = 1.0
                self.view.layoutIfNeeded()
                
            }, completion: {_ in
                
                self.buttonConstraint?.constant = -30
                UIButton.animate(withDuration: 0.4, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                    
                    self.continueButton?.alpha = 1.0
                    self.view.layoutIfNeeded()
                    
                })
            })
        })
    }
    
    private func animateExit() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.playerImageView?.alpha = 0.0
            self.playerStatsView?.alpha = 0.0
            self.roundQuestionsReportTableView?.alpha = 0.0
            self.continueButton?.alpha = 0.0
            
        }, completion: {_ in
            self.performExitNavigation()
        })
    }
    
    func performExitNavigation() {
        if (GameConfigs.shared.tempShouldUseSegues) {
            performSegue(withIdentifier: "ReportConclusionSegue", sender: nil)
        } else {
            coordinator?.goToConclusion()
            //let conclusionVC = ConclusionVC()
            //navigationController?.pushViewController(conclusionVC, animated: false)
        }
    }
    
}

extension PlayerRoundReportVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return _currentPlayer!.answeredQuestionsStore[Millenials.shared.gameRound - 1].count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let questionCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionReportCell
        
        let question = player!.questions[indexPath.row]
        let answer = player!.answeredQuestionsStore[Millenials.shared.gameRound - 1][indexPath.row]
        questionCell.configureWithQuestion(question, answer: answer)
        return questionCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionReportCell
        if let quest = cell.question(), let answered = cell.answeredQuestionObject {
            let preview = AnsweredQuestionPreviewVC()
            preview.previewQuestion(answered, question: quest)
            if #available(iOS 13.0, *) {
                present(preview, animated: true, completion: nil)
            } else {
                navigationController?.pushViewController(preview, animated: true)
            }
        }
    }
}

