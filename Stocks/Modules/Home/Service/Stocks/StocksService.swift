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
            .map { [weak self] csv in
                guard let self = self else {
                    return StocksModel(stocks: [])
                }
                
                return self.decodeStocksModels(from: csv)
            }
            .eraseToAnyPublisher()
    }
    
    private func decodeStocksModels(from csv: CSV) -> StocksModel {
        let stocksModels = csv.namedRows.reduce(into: OrderedDictionary<String, StockModel>()) { stocksModels, row in
            guard let stockPriceModel = StockPriceModel(from: row) else {
                return
            }
            
            var stockModel: StockModel
            if let oldStockModel = stocksModels[stockPriceModel.stock] {
                stockModel = oldStockModel
            } else {
                stockModel = StockModel(stock: stockPriceModel.stock, prices: [stockPriceModel])
            }
            
            stockModel.prices.append(stockPriceModel)
            stocksModels[stockPriceModel.stock] = stockModel
        }
        
        return StocksModel(stocks: stocksModels.values.map { $0 })
    }
}
