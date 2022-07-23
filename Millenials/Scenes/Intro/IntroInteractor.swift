//
//  IntroInteractor.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation

protocol IntroInteractorProtocol {
    
    func setupPlayers()
    func showMadeByAlert()
    func toggleSound()
    
}

struct IntroInteractor: IntroInteractorProtocol {
    
    var presenter: IntroPresenterProtocol?
    
    func setupPlayers() {
        presenter?.setupPlayers()
        //if let navigation =
    }
    
    func showMadeByAlert() {
        presenter?.showAbout()
    }
    
    func toggleSound() {
        AudioFeedback.shared.soundEnabled.toggle()
        presenter?.toggleSound()
    }
    
}
