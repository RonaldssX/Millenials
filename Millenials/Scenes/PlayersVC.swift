//
//  PlayersVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

var gameScene: GameSceneCoordinator!

final class PlayersVC: UIViewController {
    
    weak var coordinator: MillenialsMainCoordinator?
     var activeTextField: FlatTextField?
    
     var textFields: [FlatTextField] = []
    
     var imageController: ImageController!
    
     var player1View: LegacyPlayerSetupView! {
        
        willSet { self.player1View?.removeFromSuperview() }
        
        didSet {
            
            guard (self.player1View != nil) else { return }
            
            self.player1View.rootViewController = self
            
            self.player1View.playerPictureView = UIImageView(image: PlayerPictures.defaultAdd)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            
            self.player1View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player1View.playerTextField = FlatTextField()
            
            textFields.append(self.player1View.playerTextField)
            self.player1View.playerTextField.addTarget(self, action: #selector(modifyPlayerName(_:)), for: .touchUpInside)
            
        }
        
    }
    
    var player2View: LegacyPlayerSetupView! {
        
        willSet { self.player2View?.removeFromSuperview() }
        
        didSet {
            
            guard (self.player2View != nil) else { return }
            
            self.player2View.rootViewController = self
            
            self.player2View.playerPictureView = UIImageView(image: PlayerPictures.defaultAdd)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            self.player2View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player2View.playerTextField = FlatTextField()
            
            textFields.append(self.player2View.playerTextField)
            self.player2View.playerTextField.addTarget(self, action: #selector(modifyPlayerName(_:)), for: .editingDidBegin)
            
        }
        
    }
    
    var startGameButton: UIButton! {
        
        willSet { self.startGameButton?.removeFromSuperview() }
        
        didSet {
            
            guard (self.startGameButton != nil) else { return }
            
            self.startGameButton.addTarget(self, action: #selector(startMillenials), for: .touchUpInside)
            
            self.startGameButton.layer.cornerRadius = 30
            self.startGameButton.clipsToBounds = true
            
            self.startGameButton.alpha = 1.0
            
            self.startGameButton.backgroundColor = .Pink
            self.startGameButton.setTitleColor(.OffWhite, for: .normal)
            
            self.startGameButton.setTitle(localized("Start"), for: .normal)
            self.startGameButton.titleLabel!.font = UIFont.defaultFont(size: 20, weight: .medium)
            
            view.addSubview(self.startGameButton)
            
            self.startGameButton.translatesAutoresizingMaskIntoConstraints = false
            
            if (isiPad) {
                
                 self.startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                 self.startGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true 
                
            } else {
            
                self.startGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
                self.startGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
                
            }
            
                self.startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
                self.startGameButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true           
            
        }
        
    }
    
    var startAlert: AlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = localized("Players")
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        configureView()

    }   
    
    private func configureView() {
        
        view.addMillenialsGradient()
        
        self.player1View = LegacyPlayerSetupView()
        player1View.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: (isiPad ? 170 : 60)).isActive = true        
        
        self.player2View = LegacyPlayerSetupView()
        player2View.topAnchor.constraint(equalTo: player1View.bottomAnchor, constant: 75).isActive = true
        
        self.startGameButton = UIButton()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layoutIfNeeded()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        /*
        if let layer = view.layer.sublayers?.first(where: { $0.name == "millenialsGradient" }) {
            layer.frame = view.frame
            layer.bounds = view.bounds
        }*/
        
        for pView in [player1View, player2View].compactMap({ $0 }) {
            pView.playerPictureView.layer.cornerRadius = pView.playerPictureView.frame.width / 2
        }
        
    }
    
    @objc
    private func modifyPlayerPicture(_ sender: UITapGestureRecognizer) {
        activeTextField?.resignFirstResponder()
        let opt = [player1View.playerPictureView, player2View.playerPictureView]
        imageController = ImageController(view: self)
        imageController.takePicture(callback: {[weak self](playerPic) in
            let playerView = opt.first(where: {($0?.gestureRecognizers?.contains(sender))!})!?.superview as! LegacyPlayerSetupView
            var playerPicture: UIImage
            if (playerPic == nil || PlayerPictures.isDefaultPicture(playerPic)) {
                            
                playerPicture = PlayerPictures.defaultGame
                playerView.playerPictureView.layer.borderWidth = 3.0
                            
            } else {
                            
                playerPicture = playerPic!
                playerView.playerPictureView.layer.borderWidth = 0
                        
            }
                
            playerView.playerPicture = playerPicture
                
            if (playerPicture == PlayerPictures.defaultGame) {
                playerView.playerPictureView.image = playerView.playerPictureView.image!.withRenderingMode(.alwaysTemplate)
            }
                
                self?.imageController = nil
                
            })
    }
    
    deinit {        
        
        activeTextField = nil
        imageController = nil
        player1View = nil
        player2View = nil
        startGameButton = nil
        
    }
   

}

extension PlayersVC {
    
    func updateConstraints() {        
        
        player1View.topAnchor.constraint(equalTo: navigationController!.navigationBar.topAnchor, constant: navigationController!.navigationBar.frame.height + 90).isActive = true
        
        view.layoutIfNeeded()
        
    }
    
    @objc
    private func startMillenials() {
        
        func canStartMillenials() -> [MillenialIssues] {
            
            var issues: [MillenialIssues] = []
    
            for playerView in [player1View, player2View] {
                if let hasText = playerView?.playerTextField.hasText {
                    if (!hasText) { issues.append(.NoName) }
                    if (hasText) {
                        let text = playerView?.playerTextField.text?.filter() { !$0.isWhitespace }
                        if (text?.count == 0) { issues.append(.NoName) }
                    }
                }
                if (playerView!.isDefaultImage) { issues.append(.DefaultPicture) }
            }
            /*
            if (MDebug.shared.shouldDebug) {
                if MDebug.shared.mods.contains(.noNames) {
                    issues.removeAll() { $0 == .NoName }
                }
                if MDebug.shared.mods.contains(.noPictures) {
                    issues.removeAll() { $0 == .DefaultPicture }
                }
            } */
            
            if (issues.count == 0) { return [.None] }
            return issues
            
        }
        
        let issues = canStartMillenials()
        if (issues == [.None]) {
            return start()
        }
        
        self.startAlert = AlertController()
        startAlert?.alertTitle = localized("AlertDefaultTitle")
        
        if (issues.allSatisfy({$0 == .DefaultPicture})) {
            startAlert?.alertMessage = localized("AlertPhotoError")
        } else if (issues.allSatisfy({$0 == .NoName})) {
            startAlert?.alertMessage = localized("AlertNameError")
        } else if (issues.contains(.NoName) && issues.contains(.DefaultPicture)) {
            startAlert?.alertMessage = localized("AlertPhotoNameError")
        }
        
        let ok = UIButton()
        ok.setTitle("Ok", for: .normal)
        ok.addTarget(startAlert, action: #selector(startAlert?.dismissView), for: .touchUpInside)
        
        startAlert?.leftButton = ok
        startAlert?.display(on: self)
        
    }
    
    @objc
    private func start() {
        var players: [Player] = []
        for playerView in [player1View!, player2View!] {
            let newPlayer = Player(name: playerView.playerTextField.text ?? "", picture: playerView.playerPicture ?? PlayerPictures.defaultGame, color: playerView.playerPictureView.tintColor)
            players.append(newPlayer)
        }
        Millenials.shared.players = players
        
        if let startAlert = startAlert, presentedViewController == startAlert {
            startAlert.dismissViewBlock() { self.navigate() }
        } else {
            navigate()
        }
    
    }
    
   
    
    private func navigate() {
        Millenials.shared.startGame()
        if (GameConfigs.shared.tempShouldUseSegues) {
            performSegue(withIdentifier: "PlayersChangeSegue", sender: nil)
        } else {
            coordinator?.goToGame()
        }
    }
    
}


fileprivate enum MillenialIssues {
    
    case DefaultPicture
    case NoName
    case None
    
}



