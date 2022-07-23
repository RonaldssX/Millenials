//
//  IntroFactory.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

final class IntroFactory {
    
    static func make() -> IntroViewController {
        let controller = IntroViewController()
        let presenter = IntroPresenter(viewController: controller)
        let interactor = IntroInteractor(presenter: presenter)
        controller.configure(interactor: interactor)
        return controller
    }
    
}
