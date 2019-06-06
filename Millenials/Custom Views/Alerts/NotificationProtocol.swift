//
//  NotificationProtocol.swift
//  Millenials
//
//  Created by Ronaldo Santana on 02/06/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationProtocol {
    
    var backgroundEffect: UIVisualEffectView? { get set }
    
    var initialStatusBar: Bool { get } 
    
    func configureView()
    
    func display(on viewController: UIViewController)
    
    func addConstraints()
    
    func dismissView()    
    func dismissViewBlock(completionHandler: @escaping () -> ())
    
}

protocol NotificationViewProtocol {
    
    var buttons: [UIButton] { get set }
    
    func configure()
    
}
