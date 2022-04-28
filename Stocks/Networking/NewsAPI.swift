//
//  NewsAPI.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum NewsAPI {
    case news
}

extension NewsAPI: NetworkAPI {
    var baseURL: URL {
        API.newsURL
    }
    
    var path: String {
        switch self {
        case .news:
            return "/NewsAPI/everything/cnn.json"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
}
