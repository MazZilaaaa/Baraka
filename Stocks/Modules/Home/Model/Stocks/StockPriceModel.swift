//
//  StockPriceModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Foundation

struct StockPriceModel: Hashable {
    let stock: String
    let price: Decimal
    
    init?(from dict: [String:String]) {
        guard
            let stock = dict["STOCK"],
            let price = dict["PRICE"],
            let decPrice = Decimal(string: price) else {
                return nil
            }
        
        self.stock = stock
        self.price = decPrice
    }
}
