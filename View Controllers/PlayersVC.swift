//
//  PlayersVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 06/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

class PlayersVC: UIViewController {
    
     internal var activeTextField: FlatTextField?
    
     internal var textFields: [FlatTextField] = []
    
     internal var imageController: ImageController!
    
     public var player1View: PlayerSetupView! {
        
        didSet {
            
            guard (self.player1View != nil) else { return }
            
            self.player1View.rootViewController = self
            
            self.player1View.playerPictureView = UIImageView(image: PlayerPictures.shared.defaultAdd)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            
            self.player1View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player1View.playerTextField = FlatTextField()
            
            textFields.append(self.player1View.playerTextField)
            
            textFields[0].addTarget(self, action: #selector(modifyPlayerName(_:)), for: .touchUpInside)
            
        }
        
    }
    
     public var player2View: PlayerSetupView! {
        
        didSet {
            
            guard (self.player2View != nil) else { return }
            
            self.player2View.rootViewController = self
            
            self.player2View.playerPictureView = UIImageView(image: PlayerPictures.shared.defaultAdd)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(modifyPlayerPicture(_:)))
            
            self.player2View.playerPictureView.addGestureRecognizer(gesture)
            
            self.player2View.playerTextField = FlatTextField()
            
            textFields.append(self.player2View.playerTextField)
            
            textFields[1].addTarget(self, action: #selector(modifyPlayerName(_:)), for: .touchUpInside)
            
        }
        
    }
    
    public var startGameButton: UIButton! {
        
        didSet {
            
            self.startGameButton.addTarget(self, action: #selector(startMillenials), for: .touchUpInside)
            
            self.startGameButton.layer.cornerRadius = 30
            self.startGameButton.clipsToBounds = true
            
            self.startGameButton.alpha = 1.0
            
            self.startGameButton.backgroundColor = .Pink
            self.startGameButton.setTitleColor(.OffWhite, for: .normal)
            
            self.startGameButton.setTitle("Começar", for: .normal)
            self.startGameButton.titleLabel!.font = UIFont.defaultFont(size: 20, weight: .regular)
            
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
    
    internal var startAlert: AlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .all
        
        extendedLayoutIncludesOpaqueBars = true 
        
        configureView()

    }   
    
    private func configureView() {
        
        view.addMillenialsGradient()
        
        player1View = PlayerSetupView()
        
        player1View.topAnchor.constraint(equalTo: view.safeGuide.topAnchor, constant: (isiPad ? 170 : 60)).isActive = true        
        
        player2View = PlayerSetupView()
        
        player2View.topAnchor.constraint(equalTo: player1View.bottomAnchor, constant: 75).isActive = true
        
        startGameButton = UIButton()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layoutIfNeeded()
        
    }
    
    @objc
    private func modifyPlayerPicture(_ sender: UITapGestureRecognizer) {       
        
        let opt = [player1View.playerPictureView, player2View.playerPictureView]
        
            imageController = ImageController(view: self)
            imageController.takePicture(callback: {[weak self](playerPic) in
                
                let playerView = opt.first(where: {($0?.gestureRecognizers?.contains(sender))!})!?.superview as! PlayerSetupView
                
                    var playerPicture: UIImage
                        
                    if (playerPic == nil || playerPic == PlayerPictures.shared.defaultAdd || playerPic == PlayerPictures.shared.defaultGame) {
                            
                            playerPicture = PlayerPictures.shared.defaultGame
                            playerView.playerPictureView.layer.borderWidth = 3.0
                            
                        } else {
                            
                            playerPicture = playerPic!
                            playerView.playerPictureView.layer.borderWidth = 0
                        
                        }
                
                 playerView.playerPicture = playerPicture
                
                if (playerPicture == PlayerPictures.shared.defaultGame) { playerView.playerPictureView.image = playerView.playerPictureView.image!.withRenderingMode(.alwaysTemplate) }
                
                self?.imageController = nil
                
            })
        
                
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "PlayersChangeSegue") { Millenials.shared.startGame() }
        
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
    
    public func updateConstraints() {        
        
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
                        
                        let text = Array((playerView?.playerTextField.text)!).filter({($0 != " ")})
                        
                        if (text.count == 0) { issues.append(.NoName) }
                        
                    }
                    
                }
                
                if (playerView!.isDefaultImage) { issues.append(.DefaultPicture) }
                
            }
            
            if (issues.count == 0) {
                
                return [.None]
                
            }
            
            return issues
            
        }
        
        let issues = canStartMillenials()
        
        if (issues == [.None]) {
            
            start()
            
            return
        }
        
        self.startAlert = AlertController()
            startAlert?.alertTitle = "Aviso"
        
        
        if (issues.allSatisfy({$0 == .DefaultPicture})) {
            
            startAlert?.alertMessage = "Um ou mais jogadores não adicionaram uma foto. Tire uma foto ou use a padrão."
            
        } else if (issues.allSatisfy({$0 == .NoName})) {
            
            startAlert?.alertMessage = "Um ou mais jogadores não adicionaram um nome. Adicione os nomes e tente novamente."
            
        } else if (issues.contains(.NoName) && issues.contains(.DefaultPicture)) {
            
            startAlert?.alertMessage = "Um ou mais jogadores não adicionaram uma foto e um nome. Adicione os nomes e as fotos e tente novamente."
            
        }
        
            let ok = UIButton()
            ok.setTitle("Ok", for: .normal)
            ok.addTarget(startAlert, action: #selector(startAlert?.dismissView), for: .touchUpInside)
        
            startAlert?.leftButton = ok
        
            startAlert?.display(on: self)
        
    }
    
    @objc
    private func start() {
        
        let playerViews: [PlayerSetupView] = [player1View, player2View]
        
        Millenials.shared.players = playerViews.createPlayerObjects()
        
        startAlert?.dismissViewBlock(completionHandler: { return self.performSegue(withIdentifier: "PlayersChangeSegue", sender: nil) })
        
        performSegue(withIdentifier: "PlayersChangeSegue", sender: nil)
        
    }
    
}

fileprivate enum MillenialIssues {
    
    case DefaultPicture
    case NoName
    case None
    
}



