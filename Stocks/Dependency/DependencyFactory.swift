//
//  DependencyFactory.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

final class DependencyFactory: DependencyFactoryProtocol {
    
    // MARK: - Services
    
    var newsService: NewsServiceProtocol {
        return NewsService()
    }
    
    var stocksService: StocksServiceProtocol {
        return StocksService()
    }
}
