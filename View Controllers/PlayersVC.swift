//
//  PlayersVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit


fileprivate let defaultPicture = UIImage(named: "Player_Default")

var playerPictures: [UIImage] = [defaultPicture!, defaultPicture!]

fileprivate enum MillenialIssues {
    
    case DefaultPicture
    case NoName
    case None
    
}


class PlayersVC: UIViewController  {
    
     internal var player1View: PlayerSetupView! {
        
        didSet {
            
            self.player1View.rootViewController = self
            
            
            self.player1View.playerPictureView = UIImageView(image: defaultPicture)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            
            self.player1View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player1View.playerTextField = UITextField()
            
        }
        
    }
    
     internal var player2View: PlayerSetupView! {
        
        didSet {
            
            self.player2View.rootViewController = self
            
            self.player2View.playerPictureView = UIImageView(image: defaultPicture)            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            
            self.player2View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player2View.playerTextField = UITextField()
        }
        
    }
    
    private var startGameButton: UIButton! {
        
        didSet {
            
            self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
            self.startGameButton.layer.cornerRadius = 12
            self.startGameButton.clipsToBounds = true
            
            self.startGameButton.alpha = 0.0
            
            self.startGameButton.setTitle("Começar", for: .normal)
            self.startGameButton.setTitleColor(UIColor.Text.startGameTextColor, for: .normal)
            self.startGameButton.backgroundColor = UIColor.Button.StartButton.notReadyColor
            
            view.addSubview(self.startGameButton)
            
            self.startGameButton.addTarget(self, action: #selector(startMillenials), for: .touchUpInside)
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleNavigationBar()
        
        configureView()

        // Do any additional setup after loading the view.
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        
        return HomeBar.homeBarVisible
        
    }
    
    private func configureView() {
        
        navigationItem.hidesBackButton = true        
        
        view.backgroundColor = UIColor.View.Background.PlayersVCColor
        
        player1View = PlayerSetupView()
        
        player1View.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.bounds.height)! + 30).isActive = true        
        
        player2View = PlayerSetupView()
        
        player2View.topAnchor.constraint(equalTo: player1View.bottomAnchor, constant: 30).isActive = true
        
        startGameButton = UIButton()
        
        startGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        startGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        startGameButton.topAnchor.constraint(equalTo: player2View.bottomAnchor, constant: 60).isActive = true
        startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        view.isUserInteractionEnabled = false
        
        player1View.display {
            
            self.player2View.display {
                
                UIView.animate(withDuration: 1, animations: {
                    
                    self.startGameButton.alpha = 1.0
                    
                }, completion: {(completed) in
                                        
                    self.view.isUserInteractionEnabled = true
                    
                })
                
            }
            
        }
        
    }
    
    
    
    
    
    @objc
    private func modifyPlayerPicture(_ sender: UITapGestureRecognizer) {       
        
        let opt = [player1View.playerPictureView, player2View.playerPictureView]
        
        
        let imageController = ImageController(view: self)
            imageController.takePicture(callback: {(playerPicture) in
                
                for player in opt {
                    
                    if ((player?.gestureRecognizers?.contains(sender))!) {
                        
                        playerPictures.append(playerPicture)
                        playerPictures.swapAt(opt.firstIndex(of: player)!, playerPictures.firstIndex(of: playerPicture)!)
                        playerPictures.removeLast()
                        
                        player?.image = playerPicture.scaled(to: (player?.frame.size)!)
                        
                        
                    }
                    
                }
                
            })
        
        
    }
    
    @objc
    private func startMillenials() {
        
        let issues = canStartMillenials()
        
        switch issues {
            
        case [.None]:
            
            break
            
        default:
            
            if (issues != [.None]) {
                
                let alert = MillenialsErrorAlert()
                    alert.errors = issues
                
                return
                
            }
            
            
        }
       
       
        var players: [Player] = []
        
        let playerViews = [player1View, player2View]
        
        if (playerPictures.contains(defaultPicture!)) {
            
            if ((playerPictures.first == defaultPicture) && (playerPictures.last == defaultPicture)) {
                
                
                
            }
            
        }
        
        for playerView in playerViews {
            
            let player = Player(playerName: (playerView?.playerTextField.text!)!)
            
                player.picture = playerPictures[playerViews.firstIndex(of: playerView)!]
            
            players.append(player)
            
        }
        
        
        
        let millenials = Millenials(players: players)
        
        performSegue(withIdentifier: "PlayersChangeSegue", sender: millenials)
        
    }
    
    private func canStartMillenials() -> [MillenialIssues] {
        
        var issues: [MillenialIssues] = []
        
        for playerView in [player1View, player2View] {
            
            if let hasText = playerView?.playerTextField.hasText {
                
                if (!hasText && !issues.contains(.NoName)) {
                    
                    issues.append(.NoName)
                    
                }
                
                if (hasText) {
                    
                    let text = Array((playerView?.playerTextField.text)!).filter({($0 != " ")})
                    
                    if (text.count == 0 && !issues.contains(.NoName)) {
                        
                        issues.append(.NoName)
                        
                        
                    }
                    
                }
                
            }
            
            if (playerPictures.filter({($0 != defaultPicture)}).count != 2 && !issues.contains(.DefaultPicture)) {
                
                issues.append(.DefaultPicture)
                
            }
            
            
        }
        
        if (issues.count == 0) {
            
            return [.None]
            
        }
        
        return issues
        
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "PlayersChangeSegue") {
            
            let rootVC = segue.destination as! PlayerChangeVC
            rootVC.millenials = sender as! Millenials
            
        }
        
    }
    
    
    deinit {
        self.player1View = nil
        self.player2View = nil
        self.startGameButton = nil
    }

}

fileprivate class MillenialsErrorAlert: AlertView {
    
    public var errors: [MillenialIssues]! {
        
        didSet {
            
            
            
        }
        
    }
    
    
}


