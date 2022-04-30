//
//  StocksModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Foundation
import OrderedCollections

struct StocksModel {
    let stocks: OrderedDictionary<StockModel, [StockPriceModel]>
}
