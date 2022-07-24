//
//  AppDelegate.swift
//  Millenials
//
//  Created by Ronaldo Santana on 26/03/19.
//  Copyright © 2019 Ronaldo Santana. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

typealias key = NSAttributedString.Key

func showStatusBar() { UIApplication.shared.isStatusBarHidden = false }

func hideStatusBar() { UIApplication.shared.isStatusBarHidden = true }

var mainWindow: UIWindow?

@UIApplicationMain
class MillenialsDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: Coordinator?
    var window: UIWindow?
    var orientation: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        handleLaunchOptions(launchOptions: launchOptions)
        
        setupNavigationAppearance()
        hideStatusBar()
        
        setupAudioCategory()
        startObjects()
        
        configurePlayShortcut()
        configureCustomWindow()
        return true
    }
    
    private func configureCustomWindow() {
        var initialViewController: UIViewController
        if (GameConfigs.shared.tempShouldUseSegues) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateInitialViewController()
            initialViewController = vc!
            
        } else {
            coordinator = MillenialsMainCoordinator()
            initialViewController = coordinator!.navigationController
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        coordinator?.start()
        mainWindow = window
    }
    
    @nonobjc
    private func handleLaunchOptions(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        if let _ = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            if let window = window {
                if let nav = window.rootViewController as? NavigationVC {
                    if let intro = nav.viewControllers.first as? IntroVC {
                        intro.isShortcutLaunch = true
                        intro.performShortcutLaunch()
                    }
                }
            }
        }
        
    }
    
    
    @nonobjc
    private func startObjects() {
        
        GameConfigs.loadDefault()
        _ = Millenials.shared
        _ = Questions.shared
        _ = WatchHandler.shared
        _ = Watcher.shared
        
    }
    
    @nonobjc
    private func setupNavigationAppearance() {
        
        UINavigationBar.appearance().barTintColor = .LightPurple
        UINavigationBar.appearance().tintColor = .OffWhite
        UINavigationBar.appearance().titleTextAttributes = [key.foregroundColor: UIColor.OffWhite,
                                                            key.font: UIFont.defaultFont(size: 20, weight: .bold)]
        
    }
    
    // allows other audio sources to keep playing
    @nonobjc
    private func setupAudioCategory() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { print(error.localizedDescription) }
    }
    
}

extension MillenialsDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
    
    @nonobjc
    private func configurePlayShortcut() {
        
        let shortcutType = Bundle.main.bundleIdentifier! + ".Quickstart"
        
        let shortcutTitle = "Jogar"
        let shortcutSubtitle = "Ir direto para a ação"
        let shortcutIcon = UIApplicationShortcutIcon(type: .play)
        
        let quickstartShortcut = UIApplicationShortcutItem(type: shortcutType, localizedTitle: shortcutTitle, localizedSubtitle: shortcutSubtitle, icon: shortcutIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [quickstartShortcut]
        
    }
    
}

    /* Catalyst features. */
/*
@available(macCatalyst 13.0, iOS 13.0, *)
extension MillenialsDelegate {
    
    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)
        builder.remove(menu: .file)
        builder.remove(menu: .format)
        builder.remove(menu: .help)
    }
    
}
*/
