//
//  QuestionReportCell.swift
//  Millenials
//
//  Created by Ronaldo Santana on 28/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class QuestionReportCell: UITableViewCell {
    
    private var hasConfigured: Bool = false
    
    private var answeredQuestionObject: AnsweredQuestion?
    
    public var questionStatementLabel: UILabel! {
        
        didSet {
            
            guard (self.questionStatementLabel != nil) else { return }
            
            self.questionStatementLabel.backgroundColor = .clear
            self.questionStatementLabel.textColor = .Purple
            
            self.questionStatementLabel.textAlignment = .center
            self.questionStatementLabel.numberOfLines = 0
            
            self.questionStatementLabel.font = UIFont.defaultFont(size: 14, weight: .bold)
            
            addSubview(self.questionStatementLabel)
            
            self.questionStatementLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.questionStatementLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            self.questionStatementLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
            
            self.questionStatementLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
            
        }
        
    }
    
    public var playerAnswerLabel: UILabel! {
        
        didSet {
            
            guard (self.playerAnswerLabel != nil) else { return }
            
            self.playerAnswerLabel.backgroundColor = .clear
            self.playerAnswerLabel.textColor = .Purple
            
            self.playerAnswerLabel.textAlignment = .left
            self.playerAnswerLabel.numberOfLines = 0
            
            self.playerAnswerLabel.font = UIFont.defaultFont(size: 12, weight: .medium)
            
            addSubview(self.playerAnswerLabel)
            
            self.playerAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerAnswerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            
            self.playerAnswerLabel.topAnchor.constraint(equalTo: questionStatementLabel.bottomAnchor, constant: 15).isActive = true
            
        }
        
    }
    
    public var questionCorrectAnswerLabel: UILabel! {
        
        didSet {
            
            guard (self.questionCorrectAnswerLabel != nil) else { return }
            
            self.questionCorrectAnswerLabel.backgroundColor = .clear
            self.questionCorrectAnswerLabel.textColor = .Purple
            
            self.questionCorrectAnswerLabel.alpha = 0.0
            
            self.questionCorrectAnswerLabel.textAlignment = .left
            self.questionCorrectAnswerLabel.numberOfLines = 0
            
            self.questionCorrectAnswerLabel.font = UIFont.defaultFont(size: 12, weight: .semiBold)
            
            addSubview(self.questionCorrectAnswerLabel)
            
            self.questionCorrectAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.questionCorrectAnswerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            self.questionCorrectAnswerLabel.topAnchor.constraint(equalTo: playerAnswerLabel.bottomAnchor, constant: 10).isActive = true
            
        }
        
    }
    
    public var playerEarnedPointsLabel: UILabel! {
        
        didSet {
            
            guard (self.playerEarnedPointsLabel != nil) else { return }
            
            self.playerEarnedPointsLabel.backgroundColor = .clear
            self.playerEarnedPointsLabel.textColor = .Purple
            
            self.playerEarnedPointsLabel.textAlignment = .right
            self.playerEarnedPointsLabel.numberOfLines = 0
            
            addSubview(self.playerEarnedPointsLabel)
            
            self.playerEarnedPointsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.playerEarnedPointsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
            self.playerEarnedPointsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        defer {
            
            questionStatementLabel = UILabel()
            playerAnswerLabel = UILabel()
            questionCorrectAnswerLabel = UILabel()
            playerEarnedPointsLabel = UILabel()
            
        }
        
        isUserInteractionEnabled = false
        backgroundColor = .OffWhite
        clipsToBounds = true
        
    }
    
    public func configureWithQuestion(_ question: AnsweredQuestion) {
        
        guard (!hasConfigured) else { return }
        
        self.answeredQuestionObject = question
        
        questionStatementLabel.text = "\(answeredQuestionObject!.statement!)"
        questionCorrectAnswerLabel.text = "Resposta certa: \(answeredQuestionObject!.correctAnswer!)"
        playerEarnedPointsLabel.attributedText = attributedPointsString()
        
        if (answeredQuestionObject!.hasAnswered) {
            
            playerAnswerLabel.text = "Sua resposta: \(answeredQuestionObject!.playerAnswer!)"
            
                questionCorrectAnswerLabel.alpha = 0.0
                playerEarnedPointsLabel.alpha = 1.0
        
            if (!answeredQuestionObject!.answeredCorrectly) {
            
                questionCorrectAnswerLabel.alpha = 1.0
                playerEarnedPointsLabel.alpha = 0.0
            
            }
            
        } else {
            
            questionCorrectAnswerLabel.alpha = 1.0
            playerEarnedPointsLabel.alpha = 0.0
            
            playerAnswerLabel.text = "Não respondeu"
            
        }
        
    }

}

extension QuestionReportCell {
    
    typealias aKey = NSAttributedString.Key
    typealias color = UIColor
    
    private func attributedPointsString() -> NSAttributedString {
        
        let pointsString = "+\(answeredQuestionObject!.pointsEarned) pontos"
        
        let attribute = [aKey.foregroundColor: color.Green]
        
        let attributedString = NSMutableAttributedString(string: pointsString, attributes: [aKey.font: UIFont.defaultFont(size: 14, weight: .semiBold)])
        
            attributedString.addAttributes(attribute, range: NSRange(location: 0, length: 4))
        
        
        return NSAttributedString(attributedString: attributedString)
        
    }
    
}
