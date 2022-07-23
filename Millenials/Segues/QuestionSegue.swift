//
//  QuestionSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 01/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class QuestionSegue: UIStoryboardSegue {
    
    override func perform() {
        let containerView = initialViewController.view.superview
        let navigationController = initialViewController.navigationController as! NavigationVC
        let questionVC = finalViewController as? QuestionVC
        //questionVC?.player = Millenials.shared.currentPlayer
        
        if let questionVC = questionVC  {
            questionVC.loadViewIfNeeded()
            navigationController.pushViewController(questionVC, animated: false)
            questionVC.performSpecialAnimation()
        } else {
            navigationController.pushViewController(finalViewController, animated: true)
        }
        
    }
    
}
