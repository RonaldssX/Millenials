//
//  WinnerView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 02/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class WinnerView: UIView {
    
    internal var displayedPlayer: Player?
    unowned var rootVC: UIViewController!
    
    private var winnerImageView: UIImageView! {
        
        didSet {
            
            guard (self.winnerImageView != nil) else { return }
            
            self.winnerImageView.clipsToBounds = true
            
            let picture = displayedPlayer?.picture
            let defaultPicture = PlayerPictures.shared.defaultGame
            
            self.winnerImageView.contentMode = .scaleAspectFill
            self.winnerImageView.image = ((picture == defaultPicture) ? picture?.withRenderingMode(.alwaysTemplate) : picture)
            
            self.winnerImageView.tintColor = .OffWhite
            self.winnerImageView.backgroundColor = displayedPlayer?.color
            
            addSubview(self.winnerImageView)
            self.winnerImageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.winnerImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            self.winnerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
            
            self.winnerImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
            self.winnerImageView.widthAnchor.constraint(equalTo: self.winnerImageView.heightAnchor).isActive = true
            
        }
        
    }
    
    private var winnerStatsView: PlayerStatsView! {
        
        didSet {
            
            guard (self.winnerStatsView != nil) else { return }
            
            self.winnerStatsView.style = .Dark
            self.winnerStatsView.size = .Small
            
            self.winnerStatsView.alpha = 0.0
            
            self.winnerStatsView.customConfig(with: self, displayedPlayer, rightHeader: displayedPlayer!.name!, rightSubtitle: localized("Name"))
            self.winnerStatsView.layer.cornerRadius = 10
            
        }
        
    }
    
    public var playerQuestionsTableView: UITableView! {
        
        didSet {
            
            guard (self.playerQuestionsTableView != nil) else { return }
            
            self.playerQuestionsTableView.backgroundColor = .clear
            
            self.playerQuestionsTableView.rowHeight = UITableView.automaticDimension
            
            self.playerQuestionsTableView.delegate = self
            self.playerQuestionsTableView.dataSource = self
            
            self.playerQuestionsTableView.layer.cornerRadius = 12
            self.playerQuestionsTableView.clipsToBounds = true
            
            self.playerQuestionsTableView.showsVerticalScrollIndicator = false
            self.playerQuestionsTableView.showsHorizontalScrollIndicator = false
            
            self.playerQuestionsTableView.alwaysBounceVertical = false
            self.playerQuestionsTableView.alwaysBounceHorizontal = false
            self.playerQuestionsTableView.bounces = false
            
            self.playerQuestionsTableView.register(QuestionReportCell.self, forCellReuseIdentifier: "QuestionCell")
            
            addSubview(self.playerQuestionsTableView)
            self.playerQuestionsTableView.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerQuestionsTableView.leadingAnchor.constraint(equalTo: winnerStatsView.leadingAnchor).isActive = true
            self.playerQuestionsTableView.trailingAnchor.constraint(equalTo: winnerStatsView.trailingAnchor).isActive = true
            self.playerQuestionsTableView.topAnchor.constraint(equalTo: winnerImageView.bottomAnchor, constant: 50).isActive = true
            self.playerQuestionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
        }
        
    }
    
    public func configure() {
        
        self.displayedPlayer = Millenials.shared.endGameResults?.winningPlayer
        
        self.winnerStatsView = PlayerStatsView()
        self.winnerImageView = UIImageView()
        
        self.winnerStatsView.centerYAnchor.constraint(equalTo: winnerImageView.centerYAnchor).isActive = true
        self.winnerStatsView.roundNumberLabel.leadingAnchor.constraint(equalTo: winnerImageView.trailingAnchor, constant: 10).isActive = true
        
        self.playerQuestionsTableView = UITableView()
        
    }
    
    public func configure(with player: Player?) {
        
        self.displayedPlayer = player
        
        self.winnerStatsView = PlayerStatsView()
        self.winnerImageView = UIImageView()
        
        self.winnerStatsView.centerYAnchor.constraint(equalTo: winnerImageView.centerYAnchor).isActive = true
        self.winnerStatsView.roundNumberLabel.leadingAnchor.constraint(equalTo: winnerImageView.trailingAnchor, constant: 10).isActive = true
        
        self.playerQuestionsTableView = UITableView()
        
    }
    
    @objc
    public func display() {
        
        winnerStatsView.alpha = 1.0
        
        winnerImageView.rounded()
        winnerImageView.layer.borderWidth = 5.0
        winnerImageView.layer.borderColor = UIColor.OffWhite.cgColor
        
    }
    
    @objc
    public func updateView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.winnerImageView.alpha = 0.0
            self.winnerStatsView.alpha = 0.0
            self.playerQuestionsTableView.alpha = 0.0
            
        }, completion: { _ in
            
            self.refreshViewsData()
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.winnerImageView.alpha = 1.0
                self.winnerStatsView.alpha = 1.0
                self.playerQuestionsTableView.alpha = 1.0
                
            }, completion: nil)
            
        })
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        winnerImageView.layer.cornerRadius = winnerImageView.frame.width / 2
        
        if let leadingConst = winnerStatsView?.constraints.first(where: { $0.identifier == "masterLeading" }) {
            winnerStatsView?.removeConstraint(leadingConst)
            winnerStatsView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (isiPad ? 60 : 15)).isActive = true
        }
        
        if let trailingConst = winnerStatsView?.constraints.first(where: { $0.identifier == "masterTrailing" }) {
            winnerStatsView?.removeConstraint(trailingConst)
            winnerStatsView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (isiPad ? -60 : -15)).isActive = true
        }
        
    }

}

extension WinnerView {
    
    internal func refreshViewsData() {
        
        let results = Millenials.shared.endGameResults
        
        if (displayedPlayer == results?.winningPlayer) {
            displayedPlayer = results?.losingPlayer
        } else if (displayedPlayer == results?.losingPlayer) {
            displayedPlayer = results?.winningPlayer
        }
        
        self.winnerStatsView.removeFromSuperview()
        self.winnerImageView.removeFromSuperview()
        
        self.winnerStatsView = PlayerStatsView()
        self.winnerImageView = UIImageView()
        
        self.winnerStatsView.centerYAnchor.constraint(equalTo: winnerImageView.centerYAnchor).isActive = true
        self.winnerStatsView.roundNumberLabel.leadingAnchor.constraint(equalTo: winnerImageView.trailingAnchor, constant: 10).isActive = true 
        
        winnerImageView.rounded()
        winnerImageView.layer.borderWidth = 5.0
        winnerImageView.layer.borderColor = UIColor.OffWhite.cgColor
        
        playerQuestionsTableView.reloadData()
        
    }
    
}

extension WinnerView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return Millenials.shared.gameRound }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (displayedPlayer!.answeredQuestions.count / tableView.numberOfSections)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let questionCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionReportCell
        questionCell.configureWithQuestion(displayedPlayer!.questions[indexPath.row])
        
//        if (indexPath.section == 0) {
//
//            questionCell.configureWithQuestion(displayedPlayer!.answeredQuestions[indexPath.row])
//
//        } else if (indexPath.section == 1) {
//
//            questionCell.configureWithQuestion(displayedPlayer!.answeredQuestions[indexPath.row + 5])
//
//        } else if (indexPath.section == 2) {
//
//            questionCell.configureWithQuestion(displayedPlayer!.answeredQuestions[indexPath.row + 10])
//
//        }
        
        return questionCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionReportCell
        if let quest = cell.question() {
            let preview = AnsweredQuestionPreviewVC()
            preview.previewQuestion(quest)
            if #available(iOS 13.0, *) {
                rootVC.present(preview, animated: true, completion: nil)
            } else {
                rootVC.navigationController?.pushViewController(preview, animated: true)
            }
        }
    }
    
}
