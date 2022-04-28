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
    func createHome(output: HomeOutput?) -> HomeModule {
        HomeConfigurator().configure(dependencies: dependencies, output: output)
    }
    
    func createMainNewsList(output: MainNewsListOutput?) -> MainNewsListModule {
        return MainNewsListConfigurator().configure(dependencies: dependencies, output: output)
    }
}
