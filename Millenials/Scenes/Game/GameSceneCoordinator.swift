//
//  GameSceneRouter.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start(_ currentRootViewController: UIViewController)
    func nextScene()
    func exit()
}

final class GameSceneCoordinator: Coordinator {
    
    private typealias PlayerChangeScene = PlayerChangeVC
    private typealias QuestionScene = QuestionVC
    private typealias ReportScene = PlayerRoundReportVC
    
    private enum Scenes {
        case playerChange, question, report, conclusion
        
        case unspecified
        
        static let allCases: [GameSceneCoordinator.Scenes] = [.playerChange, .question, .report, .conclusion]
        
    }
    
    var game: Millenials
    private var navigationController: UINavigationController = UINavigationController()
    var previousScene: UIViewController!
    
    private var currentScene: Scenes
    
    init(game: Millenials) {
        self.game = game
        self.currentScene = .unspecified
        NotificationCenter.default.addObserver(self, selector: #selector(nextScene), name: notification(name: "next"), object: nil)
    }
    
    func start(_ currentRootViewController: UIViewController) {
        let rootViewController: UIViewController = getPlayerChangeScene()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
        
        self.previousScene = currentRootViewController
        currentRootViewController.modalPresentationStyle = .overFullScreen
        currentRootViewController.present(navigationController, animated: true) {
            self.currentScene = .playerChange
        }
        
    }
    
    @objc func nextScene() {
        switch currentScene {
        case .playerChange:
            goToQuestion()
            break
        case .question:
            goToReport()
            break
        case .report:
            if !(game.gameHasEnded) {
                if (tryPopToPlayerChange(shouldReconfigure: true) == nil) {
                    goToPlayerChange()
                }
            } else {
                goToConclusion()
            }
            break
        case .conclusion:
            exit()
            break;
        default:
            if (tryPopToPlayerChange(shouldReconfigure: true) == nil) {
                goToPlayerChange()
            }
        }
    }
    
    func exit() {
        if let previousScene = previousScene {
            game.endGame()
            previousScene.navigationController?.popToRootViewController(animated: true)
            navigationController.dismiss(animated: true) { [weak self] in
                self?.game.prepareForNextGame()
                self?.previousScene = nil
                print("acabou aqui")
            }
        }
    }
    // MARK: - Factories
    private func getPlayerChangeScene(_ specificPlayer: Player? = nil) -> UIViewController {
        let playerChangeScene = PlayerChangeScene()
        playerChangeScene.configure(with: specificPlayer ?? game.currentPlayer!)
        return playerChangeScene
    }
    
    private func getQuestionScene(_ specificQuestions: [Question]? = nil) -> UIViewController {
        let questionScene = QuestionScene()
        questionScene.configure(with: specificQuestions ?? game.currentPlayer!.questions, delegate: game)
        questionScene.navigationItem.setHidesBackButton(true, animated: true)
        return questionScene
    }
    
    private func getReportScene(_ specificPlayer: Player? = nil, specificRound: Int? = nil) -> UIViewController {
        let reportScene = ReportScene()
        reportScene.player = specificPlayer ?? game.currentPlayer!
        reportScene.navigationItem.setHidesBackButton(true, animated: true)
        return reportScene
    }
    
    private func getConclusionScene() -> UIViewController {
        let conclusionScene = ConclusionVC()
        conclusionScene.navigationItem.setHidesBackButton(true, animated: true)
        return conclusionScene
    }
    
    // MARK: - Go To
    
    @discardableResult func goToPlayerChange(_ specificPlayer: Player? = nil) -> UIViewController {
        let playerChangeScene = getPlayerChangeScene(specificPlayer)
        navigationController.pushViewController(playerChangeScene, animated: true)
        currentScene = .playerChange
        return playerChangeScene
    }
    
    @discardableResult func goToQuestion(_ specificQuestions: [Question]? = nil) -> UIViewController {
        let questionScene = getQuestionScene(specificQuestions)
        navigationController.pushViewController(questionScene, animated: false)
        (questionScene as! QuestionVC).performSpecialAnimation()
        currentScene = .question
        return questionScene
    }
    
    @discardableResult func goToReport(_ specificPlayer: Player? = nil, specificRound: Int? = nil) -> UIViewController {
        let reportScene = getReportScene(specificPlayer, specificRound: specificRound)
        navigationController.pushViewController(reportScene, animated: false)
        currentScene = .report
        return reportScene
    }
    
    @discardableResult func goToConclusion() -> UIViewController {
        let conclusionScene = getConclusionScene()
        navigationController.pushViewController(conclusionScene, animated: true)
        currentScene = .conclusion
        return conclusionScene
    }
    
    // MARK: - Pops
    
    @discardableResult func tryPopToPlayerChange(_ playerToReconfigure: Player? = nil, shouldReconfigure: Bool) -> UIViewController? {
        if let playerChangeScene = navigationController.children.first(where: { $0 is PlayerChangeVC }) as? PlayerChangeVC {
            if shouldReconfigure {
                playerChangeScene.configure(with: playerToReconfigure ?? game.currentPlayer!)
            }
            navigationController.popToViewController(playerChangeScene, animated: true)
            currentScene = .playerChange
            return playerChangeScene
        }
        return nil
    }
    
    @discardableResult func tryPopToQuestion(_ questionsToReconfigure: [Question]? = nil, _ delegateToReconfigure: MillenialsInteractionsProtocol? = nil, shouldReconfigure: Bool) -> UIViewController? {
        if let questionScene = navigationController.children.first(where: { $0 is QuestionVC }) as? QuestionVC {
            if shouldReconfigure, let questionsToReconfigure = questionsToReconfigure {
                questionScene.configure(with: questionsToReconfigure, delegate: delegateToReconfigure ?? game)
            }
            navigationController.popToViewController(questionScene, animated: false)
            questionScene.performSpecialAnimation()
            currentScene = .question
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
            currentScene = .report
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
            currentScene = .conclusion
            return conclusionScene
        }
        return nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
