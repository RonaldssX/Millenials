//
//  vc.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

// nao esquecer de mudar o target membership

class PlayerChangeVC: UIViewController {
    
    
    public var millenials: Millenials!
    
    private var playerPictureView: UIImageView! {
        
        didSet {
            
            view.addSubview(self.playerPictureView)
            
        }
        
    }
    
    private var answerQuestionsButton: UIButton! {
        
        didSet {
            
            self.answerQuestionsButton.addTarget(self, action: #selector(answerQuestions), for: .touchUpInside)
            
            view.addSubview(self.answerQuestionsButton)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    private func configureView() {
        
    }
    
    private func updateView() {
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard (view.isUserInteractionEnabled) else {
            
            view.isUserInteractionEnabled = true
            
            return
            
        }
        
    }
    
    @objc
    private func answerQuestions() {
        
        performSegue(withIdentifier: "PlayerQuestionSegue", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "PlayerQuestionSegue") {
            
            let questionVC = segue.destination as! QuestionVC
                questionVC.millenials = millenials
            
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.isUserInteractionEnabled = false
        
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        do {
            
            updateView()
            
        }
        
    }
    
    
}
