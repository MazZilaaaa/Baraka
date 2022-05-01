//
//  StocksData.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

enum StocksData {
    case stocksList
}

extension StocksData {
    var data: Data {
        switch self {
        case .stocksList:
            let listURL = Bundle.testBundle.url(forResource: "StocksList", withExtension: ".csv")!
            return try! Data(contentsOf: listURL)
        }
    }
}
