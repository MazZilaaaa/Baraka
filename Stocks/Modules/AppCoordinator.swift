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

final class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let modulesFactory: ModulesFactoryProtocol
    
    init(navigationController: UINavigationController,
         modulesFactory: ModulesFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.modulesFactory = modulesFactory
    }
    
    func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let homeScreen = modulesFactory.createHome(output: self)
        navigationController.setViewControllers([homeScreen.viewController], animated: false)
    }
}

extension AppCoordinator: HomeOutput {
}
