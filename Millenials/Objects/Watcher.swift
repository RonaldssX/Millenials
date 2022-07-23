//
//  Watcher.swift
//  Millenials
//
//  Created by Ronaldo Santana on 21/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit.UIButton

enum NotificationKeys: String {
    
    case playerReceivedRoundQuestions
    case questionReceivedPlayer
    
}

extension NotificationCenter {
    func addObserver(_ observer: Any, selector: Selector, name: NotificationKeys) {
        addObserver(observer, selector: selector, name: notif(name), object: nil)
    }
    
    private func notif(_ name: NotificationKeys) -> NSNotification.Name {
        return notification(name: name.rawValue)
    }
    
}

class Watcher {
    
    private typealias ContentType = Content.ContentType
    
    struct Content: Equatable {
        
        
        enum ContentType: CaseIterable {
            
            case player
            case millenials
            
            case unspecified
            
        }
        
        var type: ContentType
        var title: String
        var text: String
        
        init() {
            self.type = .unspecified
            self.title = ""
            self.text = ""
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.type == rhs.type &&
            lhs.title == rhs.title &&
            lhs.text == rhs.text
        }
        
    }
    
    var alertByTypeStore: [Watcher.Content.ContentType: [Content]]
    private var permanentAlertStore: [Content]
    var alertStore: [Content]
    private var currentlyDisplayedAlert: Content?
    
    static let shared: Watcher = {
        let ret = Watcher()
        //ret.config()
        return ret
    }()
    
    private init() {
        self.alertByTypeStore = {
            var store: [ContentType: [Content]] = [:]
            ContentType.allCases.forEach { contentType in
                store[contentType] = []
            }
            return store
        }()
        self.permanentAlertStore = []
        self.alertStore = []
    }
    
    func config() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerReceivedRoundQuestions(notification:)), name: .playerReceivedRoundQuestions)
        NotificationCenter.default.addObserver(self, selector: #selector(questionReceivedPlayer(notification:)), name: .questionReceivedPlayer)
        
    }
    
    func presentNotification(data: Content) {
                
        // nao apresentar no momento
        if (alertStore.contains(data)) {
            if (alertStore.first != data) {
                return;
            }
        }
            // nao guarda dnv
        if !(alertStore.contains(data)) {
            alertByTypeStore[data.type]?.append(data)
            alertStore.append(data)
            permanentAlertStore.append(data)
        }
        // nao apresentar dnv
        if (alertStore.first != data) {
            return
        }
        
        manageNotifications(data: data)
        
        //presentAlert(data: data)
        
    }
    
    private func manageNotifications(data: Content) {
        return presentAlert(data: data)
        if let currentlyDisplayedAlert = currentlyDisplayedAlert {
            let currentlyDisplayedAlertTyle = currentlyDisplayedAlert.type
            
        }
    }
    
    private func presentAlert(data: Content) {
        let alert = UIAlertController(title: data.title, message: data.text, preferredStyle: .alert)
        let action = UIAlertAction(title: localized("Back"), style: .cancel) { action in
            // alerta completamente saiu da tela
            if (!(self.alertStore.isEmpty) && self.alertStore[0] == data) {
                self.alertStore.removeFirst()
            }
            if !(self.alertStore.isEmpty) {
                self.presentNotification(data: self.alertStore[0])
            }
            
        }
        alert.addAction(action)
        if let mainWindow = mainWindow {
            if let rootViewController = mainWindow.rootViewController {
                rootViewController.present(alert, animated: true) {
                    print("alerted")
                }
            }
        }
    }
    
}

extension Watcher {
    
    @objc
    private func playerReceivedRoundQuestions(notification: NSNotification) {
        var content = Watcher.Content()
        content.title = #function
        if let player = notification.object as? Player {
            var functionString = #function
            let leftChar: String.Index = functionString.firstIndex(of: "(")!
            let rightChar: String.Index = functionString.firstIndex(of: ")")!
            functionString.removeSubrange(leftChar...rightChar)
            content.title = "[\(player.name)] \(functionString)"
        }
        if let questions = notification.userInfo?["questions"] as? [Question] {
            let questionIDS: [Int] = questions.map({ $0.id })
            let questionIDSString: String = questionIDS.description
            content.text += "id das questoes: \(questionIDSString)\n"
        }
        content.text += "round do millenials: \(Millenials.shared.gameRound)"
        
        presentNotification(data: content)
    }
    
    @objc
    private func questionReceivedPlayer(notification: NSNotification) {
        var content = Watcher.Content()
        var functionString = #function
        let leftChar: String.Index = functionString.firstIndex(of: "(")!
        let rightChar: String.Index = functionString.firstIndex(of: ")")!
        functionString.removeSubrange(leftChar...rightChar)
        content.title = "QuestionVC \(functionString)"
        if let player = notification.object as? Player {
            content.text = "jogador recebido: \(player.name)\n"
        } else {
            content.text = "nenhum jogador recebido\n"
        }
        content.text += "atual jogador: \(Millenials.shared.currentPlayer!.name)"
        //presentNotification(data: content)
        
        print(content.text)
    }
    
}
