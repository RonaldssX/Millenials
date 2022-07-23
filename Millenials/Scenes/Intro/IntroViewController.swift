//
//  IntroViewController.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import UIKit

final class IntroViewController: UIViewController {
    
    private var interactor: IntroInteractorProtocol?
    
    lazy var contentView: IntroView = IntroView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.animator?.performEnterAnimation(nil)
    }
    
    func configure(interactor: IntroInteractorProtocol?) {
        self.interactor = interactor
        contentView.configure(with: self, animator: contentView, tokens: .defaultTokens)
    }
    
    func changeRightButtonImage(newImage: UIImage) {
        contentView.rightButton.setImage(newImage, for: .normal)
    }
    
    func goToPlayers() {
        navigationController?.pushViewController(PlayersVC(), animated: true)
    }
    
}

extension IntroViewController: IntroViewDelegate {
    
    func mainButtonPressed() {
        interactor?.setupPlayers()
    }
    
    func leftButtonPressed() {
        interactor?.showMadeByAlert()
    }
    
    func rightButtonPressed() {
        interactor?.toggleSound()
    }
    
    
}
