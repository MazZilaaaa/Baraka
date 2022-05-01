//
//  StocksModel.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation

extension StocksModel {
    static func stub(
        stocks: [StockModel] = [.stub()]
    ) -> StocksModel {
        StocksModel(stocks: stocks)
    }
}
