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
    
    weak var answeredQuestionObject: AnsweredQuestion?
    
    public var questionStatementLabel: UILabel! {
        
        willSet { self.questionStatementLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.questionStatementLabel != nil) else { return }
            
            self.questionStatementLabel.backgroundColor = .clear
            self.questionStatementLabel.textColor = .Purple
            
            self.questionStatementLabel.textAlignment = .center
            self.questionStatementLabel.numberOfLines = 0
            
            self.questionStatementLabel.font = .defaultFont(size: 14, weight: .bold)
            
            addSubview(self.questionStatementLabel)
            
            self.questionStatementLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.questionStatementLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            self.questionStatementLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
            
            self.questionStatementLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
            
        }
        
    }
    
    private var labelStackView: UIStackView! {
        
        willSet { self.labelStackView?.removeFromSuperview() }
        
        didSet {
            
            guard (self.labelStackView != nil) else { return }
            
            self.labelStackView.alignment = .leading
            self.labelStackView.axis = .vertical
            self.labelStackView.distribution = .fillEqually
            self.labelStackView.spacing = 10
            
            addSubview(self.labelStackView)
            self.labelStackView.translatesAutoresizingMaskIntoConstraints = false
            self.labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            self.labelStackView.topAnchor.constraint(equalTo: questionStatementLabel.bottomAnchor, constant: 15).isActive = true
            self.labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
            
        }
        
    }
    
    public var playerAnswerLabel: UILabel! {
        
        didSet {
            
            guard (self.playerAnswerLabel != nil) else { return }
            
            self.playerAnswerLabel.backgroundColor = .clear
            self.playerAnswerLabel.font = .defaultFont(size: 12, weight: .medium)
            self.playerAnswerLabel.numberOfLines = 1
            self.playerAnswerLabel.textAlignment = .left
            self.playerAnswerLabel.textColor = .Purple
            
            labelStackView.addArrangedSubview(self.playerAnswerLabel)
            
        }
        
    }
    
    public var questionCorrectAnswerLabel: UILabel! {
        
        didSet {
            
            guard (self.questionCorrectAnswerLabel != nil) else { return }
            
            self.questionCorrectAnswerLabel.backgroundColor = .clear
            self.questionCorrectAnswerLabel.textColor = .Purple
            
            self.questionCorrectAnswerLabel.textAlignment = .left
            self.questionCorrectAnswerLabel.numberOfLines = 1
            
            self.questionCorrectAnswerLabel.font = .defaultFont(size: 12, weight: .semiBold)
            
            labelStackView.addArrangedSubview(self.questionCorrectAnswerLabel)
            
        }
        
    }
    
    public var playerEarnedPointsLabel: UILabel! {
        
        willSet { self.playerEarnedPointsLabel?.removeFromSuperview() }
        
        didSet {
            
            guard (self.playerEarnedPointsLabel != nil) else { return }
            
            self.playerEarnedPointsLabel.backgroundColor = .clear
            self.playerEarnedPointsLabel.textColor = .Purple
            
            self.playerEarnedPointsLabel.textAlignment = .right
            self.playerEarnedPointsLabel.numberOfLines = 1
            
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
        
        backgroundColor = .OffWhite
        clipsToBounds = true
        selectionStyle = .none
        
    }
    
    public func configureWithQuestion(_ question: Question, answer: AnsweredQuestion) {
        self.answeredQuestionObject = answer
    
        func setupCorrectAnswerLabel() {
            self.questionCorrectAnswerLabel = UILabel()
            questionCorrectAnswerLabel.text = localized("RightAnswer") + " \(question.correctAnswer)"
        }
        
        self.questionStatementLabel = UILabel()
        self.labelStackView = UIStackView()
        self.playerAnswerLabel = UILabel()
        
        questionStatementLabel.text = "\(question.statement)"
        
        if (answer.hasAnswered) {
            playerAnswerLabel.text = localized("YourAnswer") + " \(answer.playerAnswer!)"
            if (answer.answeredCorrectly) {
                playerEarnedPointsLabel = UILabel()
                playerEarnedPointsLabel.attributedText = attributedPointsString()
            }
        } else {
            playerAnswerLabel.text = localized("NoAnswer")
        }
        setupCorrectAnswerLabel()
        layoutIfNeeded()
    }
    
    @nonobjc
    public func question() -> Question? {
        return self.answeredQuestionObject?.question
    }

}

extension QuestionReportCell {
    
    typealias aKey = NSAttributedString.Key
    typealias color = UIColor
    
    private func attributedPointsString() -> NSAttributedString {
        
        let pointsLength = "\(answeredQuestionObject!.pointsEarned)".count
        let pointsString = "+\(answeredQuestionObject!.pointsEarned) " + localized("Points").lowercased()
        let attribute = [aKey.foregroundColor: color.Green]
        let attributedString = NSMutableAttributedString(string: pointsString, attributes: [aKey.font: UIFont.defaultFont(size: 14, weight: .semiBold)])
        
                                                                            /* +1 por causa do "+" */
            attributedString.addAttributes(attribute, range: NSRange(location: 0, length: pointsLength + 1))
        
        
        return NSAttributedString(attributedString: attributedString)
        
    }
    
}
