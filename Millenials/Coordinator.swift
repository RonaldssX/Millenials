//
//  Coordinator.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

@objc
protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var controllers: [UIViewController] { get set }
    var navigationController: UINavigationController { get set }
    weak var parentCoordinator: Coordinator? { get set }
    
    var hasStarted: Bool { get set }
    
    func start()
    @objc optional func end()
    
    @objc optional func childCoordinatorEnded(_ coordinator: Coordinator)
    
}

extension Coordinator {
    
    func end() {
        for coordinator in childCoordinators {
            coordinator.end()
        }
        while (navigationController.topViewController == controllers.last) {
            navigationController.popViewController(animated: false)
            controllers.removeLast()
        }
        parentCoordinator?.childCoordinatorEnded(self)
    }
    
    func childCoordinatorEnded(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}
