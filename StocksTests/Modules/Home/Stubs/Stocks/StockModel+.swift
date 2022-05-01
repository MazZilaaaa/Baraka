//
//  StockModel.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation

extension StockModel {
    static func stub(
        stockName: String = "stockName",
        prices: [StockPriceModel] = [.stub()]
    ) -> StockModel {
        StockModel(stock: stockName, prices: prices)
    }
}
