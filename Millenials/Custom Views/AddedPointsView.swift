//
//  AddedPointsView.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate var addedPoints: Int {
    
    get {
        
        guard (_currentQuestion != nil),
              (_currentPlayer != nil) else { return 100 }
        
        return (_currentPlayer?.answeredQuestions.last?.pointsEarned)!
        
    }
    
}

final class AddedPointsView: UIView {
    
    private var topConstraint: NSLayoutConstraint?  { didSet { self.topConstraint?.isActive = true } }
    private var bottomConstraint: NSLayoutConstraint?  { didSet { self.bottomConstraint?.isActive = true } }
    
    var specialText: String = "+\(addedPoints)"
    
    private var pointsLabel: UILabel! {
     
        didSet {
            
            self.pointsLabel.clipsToBounds = true
            self.pointsLabel.backgroundColor = .clear
            
            self.pointsLabel.text = specialText
            
            self.pointsLabel.textColor = .Green
            self.pointsLabel.font = UIFont.defaultFont(size: 15, weight: .medium)
            
            addSubview(self.pointsLabel)
            
            layoutIfNeeded()
            
            self.pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
            self.pointsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            self.pointsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            topConstraint = self.pointsLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.height)            
            bottomConstraint = self.pointsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: frame.height)
            
            layoutIfNeeded()
            
    }
        
    }
    
    
    public func configure(with view: UIView, _ button: UIButton, earlierButton: UIButton? = nil) {
        
        clipsToBounds = true
        backgroundColor = .clear
        
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
        
        if (earlierButton == nil) {
            
            heightAnchor.constraint(equalToConstant: 25).isActive = true
            
        } else {
            
            topAnchor.constraint(equalTo: earlierButton!.bottomAnchor).isActive = true
            
        }
        
        self.pointsLabel = UILabel()
        
    }
    
    public func display(completionHandler: @escaping (() -> ())) {
        
        topConstraint?.constant = 0; bottomConstraint?.constant = 0
        
        UILabel.animate(withDuration: 0.2, delay: 0, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
           
            self.layoutIfNeeded()
            
        }, completion: {[unowned self](completed) in
            
            self.topConstraint?.constant = -self.frame.height
            self.bottomConstraint?.constant = -self.frame.height
            
            UILabel.animate(withDuration: 0.2, delay: 0.15, options: [.preferredFramesPerSecond60, .curveEaseInOut], animations: {
                self.layoutIfNeeded()
                
                self.pointsLabel.alpha = 0.0
                
            }, completion: {[weak self](completed) in
                
                self?.removeFromSuperview()
                    completionHandler()                
                
            })
            
        })
        
    }

}

