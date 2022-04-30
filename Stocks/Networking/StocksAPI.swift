//
//  StocksAPI.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Foundation

enum StocksAPI {
    case stocks
}

extension StocksAPI: NetworkAPI {
    var baseURL: URL {
        API.stocksURL
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/dsancov/TestData/main/stocks.csv"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
}
