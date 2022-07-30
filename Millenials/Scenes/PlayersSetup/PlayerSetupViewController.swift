//
//  PlayerSetupViewController.swift
//  Millenials
//
//  Created by Ronaldo Santana on 24/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

final class PlayerSetupViewController: UIViewController {
    
    private var interactor: PlayerSetupInteractorProtocol!
    lazy var contentView: PlayerSetupView = PlayerSetupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        title = localized("Players")
    }
    
    func configure(with interactor: PlayerSetupInteractorProtocol, tokens: PlayerSetupViewTokens) {
        self.interactor = interactor
        contentView.delegate = self
    }
    
}

extension PlayerSetupViewController: PlayerSetupViewDelegate {
    
}
