//
//  LastQuestionSegue.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class LastQuestionSegue: UIStoryboardSegue {
    
    override func perform() {
        
        initialViewController.navigationController?.pushViewController(finalViewController, animated: false)
        
    }
}
