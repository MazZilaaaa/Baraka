//
//  StocksModel.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation
import OrderedCollections

extension StocksModel {
    static func stub(
        stocks: OrderedDictionary<StockModel, [StockPriceModel]> = [:]
    ) -> StocksModel {
        StocksModel(stocks: stocks)
    }
}
