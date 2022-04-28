//
//  AppCoordinator.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator {
    
    let navigationController: UINavigationController
    let modulesFactory: ModulesFactoryProtocol
    
    init(navigationController: UINavigationController,
         modulesFactory: ModulesFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.modulesFactory = modulesFactory
    }
    
    private func showHomeScreen() {
        let homeScreen = modulesFactory.createHome(output: self)
        navigationController.setViewControllers([homeScreen.viewController], animated: false)
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    func start() {
        showHomeScreen()
    }
}

// MARK: - HomeOutput

extension AppCoordinator: HomeOutput {
}
