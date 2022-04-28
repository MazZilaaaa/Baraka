//
//  AppDelegate.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder {
    
    // MARK: - Environment
    
    var window: UIWindow?
    
    private var modulesFactory: ModulesFactoryProtocol!
    private var dependencies: DependencyFactoryProtocol!
    
    // MARK: - Private
    
    private func configureApp() {
        configureDependencies()
        configureWindow()
    }
    
    private func configureDependencies() {
        dependencies = DependencyFactory()
        modulesFactory = ModulesFactory(dependencies: dependencies)
    }
    
    private func configureWindow() {
        let screenWindow = UIWindow(frame: UIScreen.main.bounds)
        screenWindow.rootViewController = UINavigationController()
        window = screenWindow
        
        screenWindow.makeKeyAndVisible()
    }
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureApp()
        
        return true
    }
}
