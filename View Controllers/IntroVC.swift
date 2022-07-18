//
//  IntroVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let millenialsLogo = UIImage(named: "Millenials_Icon")

class IntroVC: UIViewController {
    
    private var millenialsLogoView: UIImageView! {
        
        didSet {
            
            self.millenialsLogoView.backgroundColor = view.backgroundColor
            
            view.addSubview(self.millenialsLogoView)
            
            self.millenialsLogoView.translatesAutoresizingMaskIntoConstraints = false
            
            self.millenialsLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
            self.millenialsLogoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
            
            self.millenialsLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: ((navigationController?.navigationBar.bounds.height)! + 30)).isActive = true
            self.millenialsLogoView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        }
        
    }
    
    private var startButton: UIButton! {
        
        didSet {
            
            self.startButton.addTarget(self, action: #selector(startPlayerSetup), for: .touchUpInside)
            
            self.startButton.layer.cornerRadius = 8.0
            self.startButton.clipsToBounds = true
            
            self.startButton.backgroundColor = UIColor.red
            self.startButton.setTitleColor(.white, for: .normal)
            
            self.startButton.setTitle("Jogar", for: .normal)
            
            view.addSubview(self.startButton)
            
            self.startButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
            self.startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
            
            self.startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
            self.startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
        
    }
    private var startButtonConstraint: NSLayoutConstraint! {
        
        didSet {
            
            self.startButtonConstraint.isActive = true
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

        // Do any additional setup after loading the view.
    }
    
    private func configureView() {
        
        view.backgroundColor = UIColor.View.Background.questionVCColor
        
        startButton = UIButton()
        
        millenialsLogoView = UIImageView(image: millenialsLogo)
        
        
    }
    
    @objc
    private func startPlayerSetup() {
        
        performSegue(withIdentifier: "IntroPlayersSegue", sender: nil)
        
    }
    
    @IBAction func unwinds(segue: UIStoryboardSegue) {
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
