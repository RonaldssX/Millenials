//
//  WatchHandler.swift
//  Millenials
//
//  Created by Ronaldo Santana on 01/04/20.
//  Copyright © 2020 Ronaldo Santana. All rights reserved.
//

import Foundation
import WatchConnectivity

final class WatchHandler: NSObject {
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
    }
    
    static let shared = WatchHandler()
    
    private var session: WCSession {
        get { return WCSession.default }
    }
    
    func sendUpdates() {
        return;
        /// vamos voltar aqui depois
        ///  quando eu pegar meu watch novo
        guard Millenials.shared.currentPlayer != nil else { return }
        /* send profile pic */
        let currentPlayer = Millenials.shared.currentPlayer!
        let playerPic = currentPlayer.picture!.pngData()
        session.sendMessage(["picture": playerPic], replyHandler: nil, errorHandler: nil)
        print("image sent! // iphone")
    }
    
}

@available(iOS 9.3, *)
extension WatchHandler: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
}
