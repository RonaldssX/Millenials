//
//  InterfaceController.swift
//  Millenials watchOS Extension
//
//  Created by Ronaldo Santana on 10/03/20.
//  Copyright © 2020 Ronaldo Santana. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: WKInterfaceController {
    
    private var session: WCSession {
        get { return WCSession.default }
    }
    
    @IBOutlet var playerImageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            session.delegate = self
            print("session activated // watch")
            session.activate()
        }
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        playerImageView.setImage(nil)
    }

}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("message received! // watch")
        let items = returnImageAndColor(from: message)
        if let image = items.0 {
            playerImageView.setImage(image)
        }
        if let color = items.1 {
            playerImageView.setTintColor(color)
        }
    }
    
    private func returnImageAndColor(from message: [String: Any]) -> (UIImage?, UIColor?) {
        var ret: (UIImage?, UIColor?);
        
        if let image = message["picture"] {
            if let image = image as? Data {
                if let uiimage = UIImage(data: image) {
                    ret.0 = uiimage.withRenderingMode(.alwaysTemplate)
                    print("image received!!")
                }
            }
        }
        if let color = message["color"] {
            if let color = color as? UIColor {
                ret.1 = color
            }
        }
        return ret
    }
    
}
