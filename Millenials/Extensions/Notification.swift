//
//  NSNotification.swift
//  Millenials
//
//  Created by Ronaldo Santana on 20/04/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    static func post(name: String, data: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, data: data)
    }
   
    func post(name: String, data: [AnyHashable: Any]? = nil) {
        DispatchQueue.main.async {
            self.post(name: notification(name: name), object: nil, userInfo: data)
        }
    }
    
}

public func notification(name: String) -> NSNotification.Name { return NSNotification.Name(rawValue: name) }
