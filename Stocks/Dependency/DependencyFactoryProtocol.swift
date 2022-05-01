//
//  DependencyFactoryProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

protocol DependencyFactoryProtocol {
    
    // MARK: - Services
    
    var newsService: NewsServiceProtocol { get }
    
    var stocksService: StocksServiceProtocol { get }
}
