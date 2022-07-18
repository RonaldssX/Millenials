//
//  PlayerChangeVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 13/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class PlayerChangeVC: UIViewController {   
    
    public var millenials: Millenials!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        a()
        
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "PlayerQuestionSegue") {
            
            let rootVC = segue.destination as! QuestionVC
                rootVC.millenials = millenials
            
        }
        
    }
    
    func a() {
        
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "PlayerQuestionSegue", sender: nil)
            
        }
        
    }
    

}
