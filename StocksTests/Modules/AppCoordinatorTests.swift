//
//  AppCoordinatorTests.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import XCTest
@testable import Stocks

final class AppCoordinatorTests: XCTestCase {
    private var navigationController: NavigationControllerMock!
    private var modulesFactory: ModulesFactoryMock!
    
    private var appCoordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        modulesFactory = ModulesFactoryMock()
        navigationController = NavigationControllerMock()
        
        appCoordinator = AppCoordinator(
            navigationController: navigationController,
            modulesFactory: modulesFactory
        )
    }
    
    override func tearDown() {
        appCoordinator = nil
        modulesFactory = nil
        navigationController = nil
        
        super.tearDown()
    }
    
    func test_start() {
        // when
        appCoordinator.start()
        
        // then
        XCTAssertEqual(navigationController.settedViewControllers, [modulesFactory.homeViewController])
        XCTAssertTrue(navigationController.animated == false)
        XCTAssertTrue(modulesFactory.createHomeModuleCalled)
    }
}
