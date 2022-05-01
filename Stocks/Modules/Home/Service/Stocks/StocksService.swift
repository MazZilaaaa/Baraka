//
//  StocksService.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Combine
import SwiftCSV
import OrderedCollections

final class StocksService: NetworkService<StocksAPI> {
    
}

extension StocksService: StocksServiceProtocol {
    func getStocks() -> AnyPublisher<StocksModel, Error> {
        fetchData(.stocks)
            .tryMap { response -> CSV in
                guard let strCSV = String(data: response.data, encoding: .utf8) else {
                    throw NetworkError.unexpectedData
                }
                
                return try CSV(string: strCSV)
            }
            .tryMap({ csv in
                let stocks = csv.namedRows.reduce(into: OrderedDictionary<StockModel, [StockPriceModel]>()) { partialResult, row in
                    guard let stockPriceModel = StockPriceModel(from: row) else {
                        return
                    }
                    
                    let stockModel = StockModel(stock: stockPriceModel.stock)
                    var stockPriceModels: [StockPriceModel] = []
                    if let oldStockPriceModels = partialResult[stockModel] {
                        stockPriceModels = oldStockPriceModels
                    }
                    
                    stockPriceModels.append(stockPriceModel)
                    partialResult[stockModel] = stockPriceModels
                }
                
                return StocksModel(stocks: stocks)
            })
            .eraseToAnyPublisher()
    }
}
