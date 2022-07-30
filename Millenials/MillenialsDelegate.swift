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
import MillenialsDS

import ObjectiveC

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
        
       // #if DEBUG
       //     Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
       // #endif
        performInitialSetup(launchOptions)
        setupNavigationAppearance()
        setupAudioCategory()
        
        configureShortcuts()
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case Bundle.main.bundleIdentifier! + ".Quickstart":
            if let coordinator = coordinator as? MillenialsMainCoordinator {
                if coordinator.childCoordinators.isEmpty { // estamos no inicio, na tela inicial ou na tela de players
                    if let controller = coordinator.controllers.last as? IntroViewController { // primeiro controller, animaremos a entrada normalmente
                        controller.mainButtonPressed()
                    } else { // já está no players, sepa criar um alerta?
                        //Toast.toast(with: "Opa!")
                    }
                }
            }
        default: return;
        }
    }
    
    private func performInitialSetup(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // iniciamos os objetos
        startObjects()
        // definimos o coordinator
        coordinator = MillenialsMainCoordinator()
        objc_setAssociatedObject(UIApplication.shared, "MainCoordinator", coordinator!, .OBJC_ASSOCIATION_ASSIGN)
        handleLaunchOptions(launchOptions: launchOptions)
    }
    
    private func configureCustomWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        mainWindow = window
    }
    
    @nonobjc
    private func handleLaunchOptions(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        if let shortcut = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            configureCustomWindow()
            if let coordinator = coordinator { // sempre vai existir
                if !coordinator.hasStarted { coordinator.start() }
                if let introVC = coordinator.controllers.first as? IntroViewController {
                    introVC.mainButtonPressed()
                } else {
                    // nao achando o controller a gente manda a msg diretamente p o coordinator
                    (coordinator as? MillenialsMainCoordinator)?.goToPlayers()
                }
            }
        } else {
            configureCustomWindow()
            coordinator?.start()
        }
        
    }
    
    
    private func startObjects() {
        
        GameConfigs.loadDefault()
        var path: String
        if #available(iOS 13.0, *) {
            let resourceName: String = {
                switch UITraitCollection.current.userInterfaceStyle {
                case .light: return "LightTheme"
                default: return "MillenialsTheme"
                }
            }()
            path = Bundle.main.path(forResource: resourceName, ofType: "json")!
        } else {
            path = Bundle.main.path(forResource: "MillenialsTheme", ofType: "json")!
        }
        let dependecies: MillenialsDSDependencies = MillenialsDSDependencies(themePath: URL(fileURLWithPath: path), isRemote: false, worker: 0)
        MillenialsDS.shared.configure(with: dependecies)
        
    }
    

    private func setupNavigationAppearance() {
        
        UINavigationBar.appearance().barTintColor = .LightPurple
        UINavigationBar.appearance().tintColor = .OffWhite
        UINavigationBar.appearance().titleTextAttributes = [key.foregroundColor: UIColor.OffWhite,
                                                            key.font: UIFont.defaultFont(size: 20, weight: .bold)]
        
    }
    
    /// allows other audio sources to keep playing
    private func setupAudioCategory() {
        DispatchQueue.main.async {
            try? AVAudioSession.sharedInstance().setCategory(.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)
        }
    }
    
}

extension MillenialsDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }
    
    private func configureShortcuts() {
        var shortcuts: [UIApplicationShortcutItem] = []
        shortcuts.append(configurePlayShortcut())
        UIApplication.shared.shortcutItems = shortcuts
    }
    
    
    private func configurePlayShortcut() -> UIApplicationShortcutItem {
        
        let shortcutType = Bundle.main.bundleIdentifier! + ".Quickstart"
        
        let shortcutTitle = "Jogar"
        let shortcutSubtitle = "Ir direto para a ação"
        let shortcutIcon = UIApplicationShortcutIcon(type: .play)
        
        let quickstartShortcut = UIApplicationShortcutItem(type: shortcutType, localizedTitle: shortcutTitle, localizedSubtitle: shortcutSubtitle, icon: shortcutIcon, userInfo: nil)
        return quickstartShortcut
        
    }
    
}
