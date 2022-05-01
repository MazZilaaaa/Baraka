//
//  NewsData.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

enum NewsData {
    case newsList
}

extension NewsData {
    var data: Data {
        switch self {
        case .newsList:
            let listURL = Bundle.testBundle.url(forResource: "NewsList", withExtension: ".json")!
            return try! Data(contentsOf: listURL)
        }
    }
}
