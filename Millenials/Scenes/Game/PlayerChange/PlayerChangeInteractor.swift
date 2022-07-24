//
//  PlayerChangeInteractor.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation

protocol PlayerChangeInteractorProtocol {
    
    func answerQuestions()
    
}

struct PlayerChangeInteractor: PlayerChangeInteractorProtocol {
    
    var presenter: PlayerChangePresenterProtocol?
    var coordinator: GameSceneCoordinator?
    
    func answerQuestions() {
        coordinator?.goToQuestions()
    }
    
}
