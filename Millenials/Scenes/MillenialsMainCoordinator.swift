//
//  MillenialsMainCoordinator.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

final class MillenialsMainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var controllers: [UIViewController]
    var navigationController: UINavigationController
    var hasStarted: Bool
    
    weak var parentCoordinator: Coordinator?
    
    init() {
        self.childCoordinators = []
        self.controllers = []
        self.navigationController = UINavigationController()
        self.hasStarted = false
    }
    
    func start() {
        guard !hasStarted else { return }
        let initialViewController = getIntroScene()
        controllers.append(initialViewController)
        navigationController.pushViewController(initialViewController, animated: false)
        hasStarted = true
    }
    
    func goToPlayers() {
        let playersScene = getPlayersScene()
        controllers.append(playersScene)
        navigationController.pushViewController(playersScene, animated: true)
    }
    
    func goToGame() {
        let gameSceneCoordinator = GameSceneCoordinator(navigationController: navigationController, game: Millenials.shared)
        gameSceneCoordinator.parentCoordinator = self
        childCoordinators.append(gameSceneCoordinator)
        gameSceneCoordinator.start()
    }
    
}

// MARK: - Factories
extension MillenialsMainCoordinator {
    
    private func getIntroScene() -> UIViewController {
        let introScene = IntroFactory.make(coordinator: self)
        return introScene
    }
    
    private func getPlayersScene() -> UIViewController {
        let playersScene = PlayersVC()
        playersScene.coordinator = self
        return playersScene
    }
    
}
