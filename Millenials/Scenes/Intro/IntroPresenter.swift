//
//  IntroPresenter.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

protocol IntroPresenterProtocol {
    
    func setupPlayers()
    func showAbout()
    func toggleSound()
    
}

struct IntroPresenter: IntroPresenterProtocol {
    
    weak var viewController: IntroViewController?
    
    func setupPlayers() {
        viewController?.contentView.animator?.performExitAnimation({
            self.viewController?.goToPlayers()
        })
    }
    
    func showAbout() {
        let alert = AlertController()
        alert.alertMessage = localized("MadeBy")
        alert.alertTitle = localized("AlertDefaultTitle")
        
        let dismissButton = UIButton()
        dismissButton.setTitle(localized("Back"), for: .normal)
        dismissButton.addTarget(alert, action: #selector(alert.dismissView), for: .touchUpInside)
        alert.leftButton = dismissButton
        alert.display(on: viewController!)
        
    }
    
    func toggleSound() {
        var image: UIImage
        if (AudioFeedback.shared.soundEnabled) {
            image = IntroViewTokens.defaultTokens.rightButtonTokens.soundOn
        } else {
            image = IntroViewTokens.defaultTokens.rightButtonTokens.soundOff
        }
        viewController?.changeRightButtonImage(newImage: image)
    }
    
}
