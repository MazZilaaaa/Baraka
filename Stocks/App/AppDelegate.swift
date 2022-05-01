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
    
    var appCoordinator: Coordinator!
    private var modulesFactory: ModulesFactoryProtocol!
    private var dependencies: DependencyFactoryProtocol!
    
    // MARK: - Private
    
    private func configureApp() {
        configureDependencies()
        configureAppCoordinator()
    }
    
    private func configureDependencies() {
        dependencies = DependencyFactory()
        modulesFactory = ModulesFactory(dependencies: dependencies)
    }
    
    private func configureAppCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(
            navigationController: navigationController,
            modulesFactory: modulesFactory
        )
        appCoordinator.start()
        
        window?.makeKeyAndVisible()
    }
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            configureApp()
        }
        
        return true
    }
}
