//
//  StockPriceModle.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation

extension StockPriceModel {
    static func stub(
        stockName: String = "stockName",
        price: Decimal = 100
    ) -> StockPriceModel {
        StockPriceModel(
            stock: stockName,
            price: price
        )
    }
}
