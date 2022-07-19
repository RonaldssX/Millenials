//
//  Int.swift
//  Millenials
//
//  Created by Ronaldo Santana on 12/11/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation

postfix operator ++
postfix operator --

public extension Int {
    
    @discardableResult
    static postfix func ++ (val: inout Int) -> Int {
        val += 1
        return val
    }
    
    @discardableResult
    static postfix func -- (val: inout Int) -> Int {
        val -= 1
        return val
    }
    
}
