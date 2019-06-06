//
//  NavigationVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 19/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let cancelImage = UIImage(named: "ExitGame")!.scaled(to: CGSize(width: 30, height: 30))

class NavigationVC: UINavigationController {
    
   // var fill: Bool = false
    
    internal var quitAlert: AlertController? {
        
        didSet {
            
            guard (self.quitAlert != nil) else { return }
            
            self.quitAlert?.alertTitle = "Aviso"
            self.quitAlert?.alertMessage = "Tem certeza que deseja sair do jogo?"
            
            let yes = UIButton()
            yes.setTitle("Sim", for: .normal)
            yes.addTarget(self, action: #selector(returnToMainScreen), for: .touchUpInside)
            
            self.quitAlert?.leftButton = yes
            
            
            let no = UIButton()
            no.setTitle("Não", for: .normal)
            no.addTarget(self.quitAlert, action: #selector(self.quitAlert?.dismissView), for: .touchUpInside)
            
            self.quitAlert?.rightButton = no
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.transparent()
        
        //MillenialsTester.shared.currentViewController = self.visibleViewController
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(returnToMainScreen), name: notification(name: "GameHasEnded"), object: nil)

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        //MillenialsTester.shared.currentViewController = viewController
        
        if (viewController is IntroVC) { return configureIntroVC() }
        
        configureQuitGameButton(viewController)
        
        if (viewController is PlayersVC) { return configurePlayersVC(viewController) }
        
        if (viewController is PlayerChangeVC) { return configurePlayerChangeVC(viewController) }
        
        if (viewController is QuestionVC) { return configureQuestionVC(viewController) }
        
        if (viewController is PlayerRoundReportVC) { return configurePlayerRoundReportVC(viewController) }
        
        if (viewController is ConclusionVC) { return configureConclusionVC(viewController) }
        
    }    
    
    @objc
    private func quitGame() {
        
            self.quitAlert = AlertController()
        
            quitAlert?.display(on: self)
        
    }
    
    @objc
    public func returnToMainScreen() {
        
        Millenials.shared.earlyEndGame()
        
        quitAlert?.dismissViewBlock(completionHandler: {
            
            hideStatusBar()
            
            guard (self.viewControllers.first is IntroVC) else { return _ = self.popToViewController(self.viewControllers.first(where: {($0 is IntroVC)})!, animated: true) }
            
            _ = self.popToRootViewController(animated: true)
            
            return
            
        })
        
        guard (viewControllers.first is IntroVC) else { return _ = popToViewController(viewControllers.first(where: {($0 is IntroVC)})!, animated: true) }
        
        _ = popToRootViewController(animated: true)
        
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
        
        let rootVC: UIViewController = viewControllers.first(where: {($0 is IntroVC)})!
        
        rootVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if (navigationItem.rightBarButtonItem != nil) { navigationItem.setRightBarButton(nil, animated: false) }        
        
        return [rootVC]
        
    }

}

extension NavigationVC {
    
    internal func configureQuitGameButton(_ vc: UIViewController) {
        
        vc.navigationItem.hidesBackButton = true
        
        let quitGameButton = UIBarButtonItem(image: cancelImage, style: .done, target: self, action: #selector(quitGame))
        quitGameButton.tintColor = .OffWhite
        
        vc.navigationItem.setLeftBarButton(quitGameButton, animated: true)
        
    }
    
    internal func configureIntroVC() { setNavigationBarHidden(true, animated: true); hideStatusBar() }
    
    internal func configurePlayersVC(_ vc: UIViewController) {
        
        showStatusBar()
        
        let playersVC = vc as! PlayersVC
        
        setNavigationBarHidden(false, animated: false)
        
        playersVC.navigationItem.title = "Jogadores"
        
        //playersVC.player1View.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: navigationBar.bounds.height + 40).isActive = true        
        
    }
    
    internal func configurePlayerChangeVC(_ vc: UIViewController) {        
        
        hideStatusBar()
        
        guard (navigationBar.isTransparent) else { return navigationBar.transparent() }
                
    }
    
    internal func configureQuestionVC(_ vc: UIViewController) {
        
        showStatusBar()
        
        guard (navigationItem.rightBarButtonItem == nil) else { return }
        
        let rightTimer = BarTimer(time: 15)
        rightTimer.tintColor = .OffWhite
        
        vc.navigationItem.setRightBarButton(rightTimer, animated: true)
        
    }
    
    internal func configurePlayerRoundReportVC(_ vc: UIViewController) {
        
        showStatusBar()
        
        vc.navigationItem.title = "\(_currentPlayer!.name!)"
        
        vc.navigationItem.backBarButtonItem?.title = ""
        
    }
    
    internal func configureConclusionVC(_ vc: UIViewController) {
        
        let conclusionVC = vc as! ConclusionVC
        
        conclusionVC.navigationItem.setLeftBarButton(nil, animated: false)
        
        if (!conclusionVC.shouldConfigureDefault) {
            
            conclusionVC.navigationItem.setHidesBackButton(false, animated: true)
            //conclusionVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
            //conclusionVC.navigationItem.backBarButtonItem?.tintColor = .OffWhite
            interactivePopGestureRecognizer?.isEnabled = true
            
        }
        
        conclusionVC.view.layoutSubviews()
        conclusionVC.view.layoutIfNeeded()
        
    }
    
}
