//
//  Localizable.swift
//  Millenials
//
//  Created by Ronaldo Santana on 24/07/22.
//  Copyright © 2022 Ronaldo Santana. All rights reserved.
//

import Foundation
import ObjectiveC


final class Localizable {
    
    static var supportedLanguages: [String] = {
        return Bundle.main.localizations
    }()
    
    static private var lang: String = ""
    static private var bundleStore: [String: Bundle] = [:]
    static private var bundle: Bundle = {
        if let lang = UserDefaults.standard.string(forKey: "userCustomLanguageKey") {
            Localizable.lang = lang
            return loadBundle(lang: lang)
        }
        return Bundle.main
    }()
    
    static func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, bundle: bundle, comment: key)
        
    }
    
    static func localizedString(_ key: String, language: String) -> String {
        var _bundle: Bundle = Localizable.bundle
        if (lang != language) {
            _bundle = loadBundle(lang: lang)
        }
         return NSLocalizedString(key, bundle: _bundle, comment: key)
    }
    
    static func changeLanguage(newLanguage: String) {
        if supportedLanguages.contains(newLanguage) {
            UserDefaults.standard.set(newLanguage, forKey: "userCustomLanguageKey")
            updateBundle(lang: newLanguage)
            NotificationCenter.post(name: "LanguageChanged")
        }
    }
    
    private static func updateBundle(lang: String) {
        self.bundle = loadBundle(lang: lang)
        Localizable.lang = lang
    }
    
    private static func loadBundle(lang: String) -> Bundle {
        if let bundle = bundleStore[lang] {
            return bundle
        }
        let path = Bundle.main.path(forResource: lang, ofType: "lproj") ?? Bundle.main.bundlePath
        return Bundle(path: path) ?? Bundle.main
    }
    
}

extension String {
    var localized: String {
        return Localizable.localizedString(self)
    }
}

func localized(_ key: String) -> String {
    return Localizable.localizedString(key)
}
