//
//  NavigationVC.swift
//  Millenials
//
//  Created by Ronaldo Santana on 19/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit

fileprivate let cancelImage = UIImage(named: "ExitGame")!.scaled(to: CGSize(width: 30, height: 30))

final class NavigationVC: UINavigationController {
    
    var quitAlert: AlertController? {
        
        didSet {
            
            guard (self.quitAlert != nil) else { return }
            
            self.quitAlert?.alertTitle = localized("AlertDefaultTitle")
            self.quitAlert?.alertMessage = localized("ConfirmGameExit")
            
            let yes = UIButton()
            yes.setTitle(localized("Yes"), for: .normal)
            yes.addTarget(self, action: #selector(returnToMainScreen), for: .touchUpInside)
            
            self.quitAlert?.leftButton = yes
            
            let no = UIButton()
            no.setTitle(localized("No"), for: .normal)
            no.addTarget(self, action: #selector(cancelQuit), for: .touchUpInside)
            
            self.quitAlert?.rightButton = no
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.transparent()
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(returnToMainScreen), name: notification(name: "GameHasEnded"), object: nil)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if (viewController is IntroVC)                   { return configureIntroVC() }
        if (viewController is AnsweredQuestionPreviewVC) { return configurePreviewVC(viewController) }
        
        configureQuitGameButton(viewController)
        
        if (viewController is PlayersVC)                 { return configurePlayersVC(viewController) }
        if (viewController is PlayerChangeVC)            { return configurePlayerChangeVC(viewController) }
        if (viewController is QuestionVC)                { return configureQuestionVC(viewController) }
        if (viewController is PlayerRoundReportVC)       { return configurePlayerRoundReportVC(viewController) }
        if (viewController is ConclusionVC)              { return configureConclusionVC(viewController) }
        
    }
    
    @objc
    private func quitGame() {
        
        self.quitAlert = AlertController()
        quitAlert?.display(on: self)
        
    }
    
    @objc
    private func cancelQuit() {
        
        guard (navigationItem.rightBarButtonItem != nil),
            let barTimer = navigationItem.rightBarButtonItem as? BarTimer else { quitAlert?.dismissView(); return }
        
        barTimer.startTimer()
        
        quitAlert?.dismissViewBlock {
            self.quitAlert = nil
            
        }
        
    }
    
    @objc
    func returnToMainScreen() {
        
        Millenials.shared.earlyEndGame()
        
        quitAlert?.dismissViewBlock {
            
            self.quitAlert = nil
            self.exitToMainScreen()
            
        }
        
    }
    
    @objc
    func exitToMainScreen() {
        
        hideStatusBar()
        _ = popToRootViewController(animated: true)
        
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
        
        let rootVC: UIViewController = viewControllers.first(where: {($0 is IntroVC)})!
        rootVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        return [rootVC]
        
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        super.popToViewController(viewController, animated: animated)
        
        let intro = viewControllers.first() { $0 is IntroVC }!
        return [viewController, intro]
    }
    
    func returnToQuestionVC() {
        if let questionVC = viewControllers.first(where: { $0 is QuestionVC }) {
            (questionVC as! QuestionVC).updateAnimation()
           _ = popToViewController(questionVC, animated: true)
        }
    }
    
}

// MARK: - Animation transition
extension NavigationVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is IntroVC        && toVC is PlayersVC      { return OpenAnimator() }
        if fromVC is PlayersVC      && toVC is PlayerChangeVC { return nil }
        if fromVC is PlayerChangeVC && toVC is QuestionVC     { return nil }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        nil
    }
    
}

extension NavigationVC {
    
    func configureQuitGameButton(_ vc: UIViewController) {
        
        vc.navigationItem.hidesBackButton = true
        
        let quitGameButton = UIBarButtonItem(image: cancelImage, style: .done, target: self, action: #selector(quitGame))
        quitGameButton.tintColor = .OffWhite
        
        vc.navigationItem.setLeftBarButton(quitGameButton, animated: true)
        
    }
    
    func configureIntroVC() {
        
        setNavigationBarHidden(true, animated: true)
        
        hideStatusBar()
        
    }
    
    func configurePlayersVC(_ vc: UIViewController) {
        
        showStatusBar()
        
        let playersVC = vc as! PlayersVC
        playersVC.navigationItem.title = localized("Players")
        
        setNavigationBarHidden(false, animated: false)
        
    }
    
    func configurePlayerChangeVC(_ vc: UIViewController) {
        
        hideStatusBar()
        viewControllers.removeAll() { $0 is PlayersVC }
        
        guard (navigationBar.isTransparent) else { return navigationBar.transparent() }
        
    }
    
    func configureQuestionVC(_ vc: UIViewController) {
        
        showStatusBar()
        if MDebug.shared.shouldDebug && MDebug.shared.mods.contains(.noQuestionTimer) { return }
        guard (navigationItem.rightBarButtonItem == nil) else { return }
        
        let rightTimer = BarTimer(time: questionCountdownTime)
        rightTimer.tintColor = .OffWhite
        
        vc.navigationItem.setRightBarButton(rightTimer, animated: true)
        
    }
    
    func configurePlayerRoundReportVC(_ vc: UIViewController) {
        
        showStatusBar()
        vc.navigationItem.title = String(_currentPlayer!.name!)
        
    }
    
    func configurePreviewVC(_ vc: UIViewController) {
        
        showStatusBar()

    }
    
    func configureConclusionVC(_ vc: UIViewController) {
        
        let conclusionVC = vc as! ConclusionVC
        conclusionVC.navigationItem.setLeftBarButton(nil, animated: false)
        if (!conclusionVC.shouldConfigureDefault) {
            
            conclusionVC.navigationItem.setHidesBackButton(false, animated: true)
            interactivePopGestureRecognizer?.isEnabled = true
            
        }
        
        conclusionVC.view.layoutSubviews()
        conclusionVC.view.layoutIfNeeded()
        
    }
    
}
