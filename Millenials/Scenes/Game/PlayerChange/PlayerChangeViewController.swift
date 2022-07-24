//
//  PlayerChangeViewController.swift
//  Millenials
//
//  Created by Ronaldo Santana on 23/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

final class PlayerChangeViewController: UIViewController {
    
    private var interactor: PlayerChangeInteractorProtocol?
    lazy var contentView: PlayerChangeView = PlayerChangeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // start button timer
    }
    
    func configure(with player: Player, interactor: PlayerChangeInteractorProtocol) {
        self.interactor = interactor
        contentView.configure(with: player, delegate: self, animator: contentView, tokens: .defaultTokens)
    }
    
    func reconfigure(with player: Player) {
        contentView.reconfigure(with: player)
    }
    
}

extension PlayerChangeViewController: PlayerChangeViewDelegate {
    
    func buttonPressed() {
        interactor?.answerQuestions()
    }
    
}
