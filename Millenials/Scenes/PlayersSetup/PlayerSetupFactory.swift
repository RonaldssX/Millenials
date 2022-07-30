//
//  PlayerSetupFactory.swift
//  Millenials
//
//  Created by Ronaldo Santana on 24/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//


final class PlayerSetupFactory {
    static func make(tokens: PlayerSetupViewTokens) -> PlayerSetupViewController {
        let controller = PlayerSetupViewController()
        let presenter = PlayerSetupPresenter(viewController: controller)
        let interactor = PlayerSetupInteractor(presenter: presenter)
        controller.configure(with: interactor, tokens: tokens)
        return controller
    }
}
