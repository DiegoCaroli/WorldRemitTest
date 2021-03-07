//
//  AppDelegate.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: MainCoordinator?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let isUnitTesting = ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "YES"

        if !isUnitTesting {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window

            let appDependencyContainer = AppDependencyContainer()
            coordinator = MainCoordinator(window: window, appDependencyContainer: appDependencyContainer)
            coordinator?.start()
            window.makeKeyAndVisible()
        }

        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

