//
//  GameSceneRouter.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

#warning("talvez fazer coordinator para player report")

final class GameSceneCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]
    var controllers: [UIViewController]
    var navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    var game: Millenials!
    
    init(navigationController: UINavigationController, game: Millenials) {
        self.childCoordinators = []
        self.controllers = []
        self.navigationController = navigationController
        self.game = game
    }
    
    // playerChange -> question -> player report -> conclusion
    func start() {
        let initialViewController = getPlayerChangeScene()
        navigationController.delegate = self
        controllers.append(initialViewController)
        navigationController.pushViewController(initialViewController, animated: true)
    }
    
    func goToQuestions() {
        let questionsScene = getQuestionScene()
        controllers.append(questionsScene)
        navigationController.pushViewController(questionsScene, animated: false)
        (questionsScene as? QuestionVC)?.performSpecialAnimation()
    }
    
    func goToReport() {
        let reportScene = getReportScene()
        controllers.append(reportScene)
        navigationController.pushViewController(reportScene, animated: true)
    }
    
    func goToPlayerChange() {
        // provavelmente já existe ok
        if let playerChangeScene = navigationController.viewControllers.first(where: { $0 is PlayerChangeViewController }) as? PlayerChangeViewController {
            playerChangeScene.reconfigure(with: game.currentPlayer!)
            navigationController.popToViewController(playerChangeScene, animated: true)
        } else {
            let playerChangeScene = getPlayerChangeScene()
            navigationController.pushViewController(playerChangeScene, animated: true)
        }
    }
    
    func goToConclusion() {
        let conclusionScene = getConclusionScene()
        controllers.append(conclusionScene)
        navigationController.pushViewController(conclusionScene, animated: true)
    }
    
    
    func exit() {
        navigationController.delegate = nil
        game.endGame()
        game.prepareForNextGame()
        end()
    }
    
    private func cleanControllers() {
        var i: Int = 0
        while (i != controllers.count) {
            if !(navigationController.viewControllers.contains(controllers[i])) {
                controllers.remove(at: i)
                continue
            }
            i++
        }
    }
    
    // MARK: - Pops
    
    @discardableResult func tryPopToPlayerChange(_ playerToReconfigure: Player? = nil, shouldReconfigure: Bool) -> UIViewController? {
        if let playerChangeScene = navigationController.children.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC {
            if shouldReconfigure {
                playerChangeScene.configure(with: playerToReconfigure ?? game.currentPlayer!)
            }
            navigationController.popToViewController(playerChangeScene, animated: true)
            return playerChangeScene
        }
        return nil
    }
    
    @discardableResult func tryPopToQuestion(_ questionsToReconfigure: [Question]? = nil, _ delegateToReconfigure: MillenialsInteractionsProtocol? = nil, shouldReconfigure: Bool) -> UIViewController? {
        if let questionScene = navigationController.children.first(where: { $0 is QuestionVC }) as? QuestionVC {
            if shouldReconfigure, let questionsToReconfigure = questionsToReconfigure {
                questionScene.configure(with: questionsToReconfigure, delegate: delegateToReconfigure ?? game, coordinator: self)
            }
            navigationController.popToViewController(questionScene, animated: false)
            questionScene.performSpecialAnimation()
            return questionScene
        }
        return nil
    }
    
    @discardableResult func tryPopToReport(_ playerToReconfigure: Player? = nil, _ specificRoundToReconfigure: Int? = nil, shouldReconfigure: Bool) -> UIViewController? {
        if let reportScene = navigationController.children.first(where: { $0 is PlayerRoundReportVC }) as? PlayerRoundReportVC {
            if shouldReconfigure, let playerToReconfigure = playerToReconfigure {
                reportScene.player = playerToReconfigure
            }
            navigationController.popToViewController(reportScene, animated: true)
            return reportScene
        }
        return nil
    }
    
    @discardableResult func tryPopToConclusion(shouldReconfigure: Bool) -> UIViewController? {
        if let conclusionScene = navigationController.children.first(where: { $0 is ConclusionVC }) as? ConclusionVC {
            if shouldReconfigure {
                /// reconfigure()
            }
            navigationController.popToViewController(conclusionScene, animated: true)
            return conclusionScene
        }
        return nil
    }
    
}

// MARK: - Factories
extension GameSceneCoordinator {
    
    private func getPlayerChangeScene(_ specificPlayer: Player? = nil) -> UIViewController {
        let playerChangeScene = PlayerChangeFactory.make(coordinator: self, player: specificPlayer ?? game.currentPlayer!)
        return playerChangeScene
    }
    
    private func getQuestionScene(_ specificQuestions: [Question]? = nil) -> UIViewController {
        let questionScene = QuestionVC()
        questionScene.configure(with: specificQuestions ?? game.currentPlayer!.questions, delegate: game, coordinator: self)
        questionScene.navigationItem.setHidesBackButton(true, animated: true)
        return questionScene
    }
    
    private func getReportScene(_ specificPlayer: Player? = nil, specificRound: Int? = nil) -> UIViewController {
        let reportScene = PlayerRoundReportVC()
        reportScene.player = specificPlayer ?? game.currentPlayer!
        reportScene.coordinator = self
        reportScene.navigationItem.setHidesBackButton(true, animated: true)
        return reportScene
    }
    
    private func getConclusionScene() -> UIViewController {
        let conclusionScene = ConclusionVC()
        conclusionScene.coordinator = self
        conclusionScene.navigationItem.setHidesBackButton(true, animated: true)
        return conclusionScene
    }
    
}

extension GameSceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if (viewController is PlayerChangeViewController),
           let _ = navigationController.transitionCoordinator?.viewController(forKey: .from) as? PlayerRoundReportVC {
            cleanControllers()
        }
    }
}
