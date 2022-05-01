//
//  ModulesFactory.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

final class ModulesFactory {
    private let dependencies: DependencyFactoryProtocol
    
    init(dependencies: DependencyFactoryProtocol) {
        self.dependencies = dependencies
    }
}

extension ModulesFactory: ModulesFactoryProtocol {
    func createHomeModule() -> HomeModule {
        HomeConfigurator().configure(dependencies: dependencies)
    }
}
