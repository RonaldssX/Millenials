//
//  PlayerChangeFactory.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

final class PlayerChangeFactory {
    
    static func make(coordinator: GameSceneCoordinator, player: Player) -> PlayerChangeViewController {
        let controller = PlayerChangeViewController()
        let presenter = PlayerChangePresenter(viewController: controller)
        let interactor = PlayerChangeInteractor(presenter: presenter, coordinator: coordinator)
        controller.configure(with: player, interactor: interactor)
        return controller
    }
    
}
