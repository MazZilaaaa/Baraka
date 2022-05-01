//
//  StocksServiceProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Combine

protocol StocksServiceProtocol {
    func getStocks() -> AnyPublisher<StocksModel, Error>
}
