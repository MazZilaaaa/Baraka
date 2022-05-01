//
//  NewsAPI.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum ArticlesAPI {
    case news
}

extension ArticlesAPI: NetworkAPI {
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
