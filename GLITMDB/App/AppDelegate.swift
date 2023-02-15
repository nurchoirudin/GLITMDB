//
//  AppDelegate.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = NSLocalizedString("Done", comment: "")
        makeViewAndSetupAppearance()
        return true
    }
    
    func makeViewAndSetupAppearance() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = Injection().resolve(MovieHomeVC.self)
        let navVC = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
}

