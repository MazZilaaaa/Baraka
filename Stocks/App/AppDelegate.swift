//
//  AppDelegate.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureApp()
        
        return true
    }
    
    private func configureApp() {
        // Override point for customisation after application launch.
        let screenWindow = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        screenWindow.rootViewController = navigationController
        window = screenWindow
        
        screenWindow.makeKeyAndVisible()
    }
}
