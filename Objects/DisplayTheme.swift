//
//  DisplayTheme.swift
//  Millenials
//
//  Created by Ronaldo Santana on 18/05/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import Foundation
import UIKit

fileprivate let darkmode = UIImage(named: "DarkMode")
fileprivate let lightmode = UIImage(named: "LightMode")

fileprivate protocol Theme {
    
    /* general, applies to all */
    
      var statusBarStyle: UIStatusBarStyle { get }
      var navigationBarColor: UIColor { get }
      var navigationBarItemColor: UIColor { get }
      var backgroundColor: UIColor { get }
      var keyboardStyle: UIKeyboardAppearance { get }
      var imageColor: UIColor { get }
    
    /* intro vc exclusive */
    
      var gradientColors: [UIColor] { get }
      var logoColor: UIColor { get }
      var introButtonColor: UIColor { get }
      var introButtonContentColor: UIColor { get }
      var themeImage: UIImage { get }
    
    
    /* players vc exclusive */
    
      var textFieldColor: UIColor { get }
      var textFieldTextColor: UIColor { get }
      var playersButtonColor: UIColor { get }
      var playersButtonTextColor: UIColor { get }
    
    /* player change vc exclusive */
    
      var startPlayButtonColor: UIColor { get }
      var startPlayButtonTextColor: UIColor { get }
    
    /* question vc exclusive */
    
      var questionViewColor: UIColor { get }
      var questionLabelColor: UIColor { get }
    
      var answerButtonColor: UIColor { get }
      var answerButtonTextColor: UIColor { get }
    
    
}

fileprivate struct LightMode: Theme {
    
    /* general, applies to all */
    
        var statusBarStyle: UIStatusBarStyle = .lightContent
        var navigationBarColor: UIColor = .LightPurple
        var navigationBarItemColor: UIColor = .OffWhite
        var backgroundColor: UIColor = .Purple
        var keyboardStyle: UIKeyboardAppearance = .light
        var imageColor: UIColor = .OffWhite
    
    /* intro vc exclusive */
    
        var gradientColors: [UIColor] = [.purple, .green]
        var logoColor: UIColor = .OffWhite
        var introButtonColor: UIColor = UIColor.OffWhite.withAlphaComponent(0.96)
        var introButtonContentColor: UIColor = .LightPurple
        var themeImage: UIImage = lightmode!
    
    /* players vc exclusive */
    
        var textFieldColor: UIColor = .LightPurple
        var textFieldTextColor: UIColor = .OffWhite
        var playersButtonColor: UIColor = UIColor.LightPurple.withAlphaComponent(0.75)
        var playersButtonTextColor: UIColor = .OffWhite
    
    /* player change vc exclusive */
    
        var startPlayButtonColor: UIColor = UIColor.Green.withAlphaComponent(0.8)
        var startPlayButtonTextColor: UIColor = .OffWhite
    
    /* question vc exclusive */
    
        var questionViewColor: UIColor = .OffWhite
        var questionLabelColor: UIColor = .OffBlack
        var answerButtonColor: UIColor = .LightPurple
        var answerButtonTextColor: UIColor = .OffWhite
    
}

fileprivate struct DarkMode: Theme {
    
    /* general, applies to all */
    
       var statusBarStyle: UIStatusBarStyle = .lightContent
       var navigationBarColor: UIColor = .LightPurple
       var navigationBarItemColor: UIColor = .OffWhite
       var backgroundColor: UIColor = .Purple
       var keyboardStyle: UIKeyboardAppearance = .dark
       var imageColor: UIColor = .OffBlack
    
    /* intro vc exclusive */
    
       var gradientColors: [UIColor] = [.Purple, .LightPurple]
       var logoColor: UIColor = .OffWhite
       var introButtonColor: UIColor = UIColor.OffWhite.withAlphaComponent(0.96)
       var introButtonContentColor: UIColor = .LightPurple
       var themeImage: UIImage = darkmode!
    
    /* players vc exclusive */
    
       var textFieldColor: UIColor = .LightPurple
       var textFieldTextColor: UIColor = .OffWhite
       var playersButtonColor: UIColor = UIColor.LightPurple.withAlphaComponent(0.75)
       var playersButtonTextColor: UIColor = .OffWhite
    
    /* player change vc exclusive */
    
       var startPlayButtonColor: UIColor = UIColor.Green.withAlphaComponent(0.8)
       var startPlayButtonTextColor: UIColor = .OffWhite
    
    /* question vc exclusive */
    
       var questionViewColor: UIColor = .OffWhite
       var questionLabelColor: UIColor = .OffBlack
       var answerButtonColor: UIColor = .LightPurple
       var answerButtonTextColor: UIColor = .OffWhite
    
}


enum DisplayModes: CaseIterable {
    
    case light
    case dark
    
    init?(id: Int) {
        
        switch id {
            
        case 1: self = .light
        case 2: self = .dark
            
        default: return nil
            
        }
        
    }
    
}

class DisplayMode {
    
    
    static let shared = DisplayMode()
    
    var currentTheme: DisplayModes = .dark
    
    private var theme: Theme! {       
        
        let themes: [Theme] = [LightMode(), DarkMode()]
        
        return themes[DisplayModes.allCases.firstIndex(of: currentTheme)!]
        
    }
    
    public func setLightMode() {
        
        guard (currentTheme != .light) else { return }
        
        currentTheme = .light
        
        applyTheme()
        
    }
    
     public func setDarkMode() {
        
        guard (currentTheme != .dark) else { return }
        
        currentTheme = .dark
        
        applyTheme()
        
    }
    
     public func toggleMode() {
        
        guard (currentTheme == .dark)  else { return setDarkMode() }
        guard (currentTheme == .light) else { return setLightMode() }
        
    }
    
    public func applyTheme() {
        
        return 
        
            /*
            
        print("theme changed, new theme = \(currentTheme) ")
        
        /* all */
        
        
        UINavigationBar.appearance().barTintColor = theme.navigationBarColor
        UINavigationBar.appearance().titleTextAttributes = [key.foregroundColor: theme.navigationBarItemColor,
                                                            key.font: UIFont.defaultFont(size: 20, weight: .bold)]
        
        UITextField.appearance().keyboardAppearance = theme.keyboardStyle
        
        /* almost all */
        
        UIImageView.appearance(whenContainedInInstancesOf: [PlayersVC.self, PlayerChangeVC.self]).tintColor = theme.imageColor
        
        /* intro vc */
        
        UIView.appearance(whenContainedInInstancesOf: [IntroVC.self]).gradient(color1: theme.gradientColors[0], color2: theme.gradientColors[1])
        UIImageView.appearance(whenContainedInInstancesOf: [IntroVC.self]).tintColor = theme.logoColor
        
        UIButton.appearance(whenContainedInInstancesOf: [IntroVC.self]).backgroundColor = theme.introButtonColor
        UIButton.appearance(whenContainedInInstancesOf: [IntroVC.self]).setTitleColor(theme.introButtonContentColor, for: .normal)
        
        /* players vc */
        
        UIView.appearance(whenContainedInInstancesOf: [PlayersVC.self, PlayerSetupView.self]).backgroundColor = theme.backgroundColor
        
        UIButton.appearance(whenContainedInInstancesOf: [PlayersVC.self]).backgroundColor = theme.playersButtonColor
        UIButton.appearance(whenContainedInInstancesOf: [PlayersVC.self]).setTitleColor(theme.playersButtonTextColor, for: .normal)
        
        UITextField.appearance(whenContainedInInstancesOf: [PlayersVC.self]).backgroundColor = theme.textFieldColor
        UITextField.appearance(whenContainedInInstancesOf: [PlayersVC.self]).textColor = theme.textFieldTextColor
        
        /* player change vc */
        
        UIView.appearance(whenContainedInInstancesOf: [PlayerChangeVC.self]).backgroundColor = theme.backgroundColor
        
        UIButton.appearance(whenContainedInInstancesOf: [PlayerChangeVC.self]).backgroundColor = theme.startPlayButtonColor
        UIButton.appearance(whenContainedInInstancesOf: [PlayerChangeVC.self]).setTitleColor(theme.startPlayButtonTextColor, for: .normal)
        
        /* question vc */
        
        UIView.appearance(whenContainedInInstancesOf: [QuestionVC.self]).backgroundColor = theme.backgroundColor
        
        QuestionView.appearance().backgroundColor = theme.questionViewColor
        UILabel.appearance(whenContainedInInstancesOf: [QuestionVC.self]).textColor = theme.questionLabelColor
        
        UIButton.appearance(whenContainedInInstancesOf: [QuestionVC.self]).backgroundColor = theme.answerButtonColor
        UIButton.appearance(whenContainedInInstancesOf: [QuestionVC.self]).setTitleColor(theme.answerButtonTextColor, for: .normal)
        
        UIApplication.shared.windows.reload()
        
        */
        
    }
    
}
