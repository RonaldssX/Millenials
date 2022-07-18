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
    
    var fill: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()        

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)               
        
        if !(viewController is IntroVC) {
            
            if (viewController is PlayersVC) {
                
                viewController.navigationItem.title = "Jogadores"
                
                if (fill) {
                    
                    let rootVC = viewController as! PlayersVC
                        rootVC.viewDidLoad()
                    
                    rootVC.player1View.playerTextField.text = "naldin"
                    rootVC.player2View.playerTextField.text = "naldao"
                    playerPictures = [UIImage(), UIImage()]
                    
                        rootVC.toggleNavigationBar()
                    
                }
                
            }
            
            if (viewController is PlayerChangeVC) {
                
                viewController.navigationItem.title = "Millenials"
                
            }
            
            if (viewController is QuestionVC) {
                
                let rightTimer = BarTimer(time: 15)
                
                viewController.navigationItem.setRightBarButton(rightTimer, animated: true)
                viewController.navigationItem.rightBarButtonItem?.tintColor = UIColor.NavigationBar.barTintColor
                
                    rightTimer.superview = viewController.navigationItem
                
            }
            
            viewController.navigationItem.hidesBackButton = true
            
            let leftButton = UIBarButtonItem(image: cancelImage, style: .done, target: self, action: #selector(quitGame))
            
            viewController.navigationItem.setLeftBarButton(leftButton, animated: true)
            viewController.navigationItem.leftBarButtonItem?.tintColor = UIColor.NavigationBar.barTintColor
            
            return
        }
        
        setNavigationBarHidden(true, animated: true)
        
    }
    
    @objc
    private func quitGame() {
        
        let confirmationAlert = AlertView(alert: .Alert, root: visibleViewController)
            confirmationAlert.alertMessage = "Tem certeza que deseja sair do jogo?"
        
        let confirmButton = AlertButton(title: "Sim")
        confirmButton.addTarget(self, action: #selector(returnToMainScreen), for: .touchUpInside)
        
        let rejectButton = AlertButton(title: "Não")
        rejectButton.addTarget(confirmationAlert, action: #selector(confirmationAlert.toggleView), for: .touchUpInside)
        
            confirmationAlert.alertButtons = [confirmButton, rejectButton]
        
            confirmationAlert.displayAlert()
        
    }
    
    
    @objc
    private func returnToMainScreen() {
        
        if (viewControllers.first is IntroVC) {
            
            _ = popToRootViewController(animated: true)
            
            return
            
        }
        
        for viewController in viewControllers {
            
            if (viewController is IntroVC) {
                
                self.popToViewController(viewController, animated: true)
                
                return
                
            }
            
        }
        
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
        
        let rootVC: [UIViewController] = viewControllers.filter({($0 is IntroVC)})
        
        rootVC.first?.toggleNavigationBar()
        
        return rootVC
        
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

