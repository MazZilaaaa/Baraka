//
//  HomeStockCellModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Foundation

final class HomeStockCellModel {
    let stockPriceModel: StockPriceModel
    
    var title: String {
        return stockPriceModel.stock
    }
    
    var price: String? {
        NumberFormatter.currencyFormatter.string(for: stockPriceModel.price)
    }
    
    init(stockPriceModel: StockPriceModel) {
        self.stockPriceModel = stockPriceModel
    }
}

extension HomeStockCellModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(stockPriceModel)
    }
    
    static func == (lhs: HomeStockCellModel, rhs: HomeStockCellModel) -> Bool {
        lhs.stockPriceModel == rhs.stockPriceModel
    }
}

