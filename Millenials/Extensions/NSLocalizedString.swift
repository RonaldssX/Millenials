//
//  NSLocalizedString.swift
//  Millenials
//
//  Created by Ronaldo Santana on 25/11/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

public func localized(_ key: String) -> String {
    return NSLocalizedString(key, comment: key)
}
