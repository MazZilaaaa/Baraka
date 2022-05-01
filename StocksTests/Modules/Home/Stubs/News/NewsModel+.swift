//
//  NewsModel.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation

extension NewsModel {
    static func stub(
        status: NewsModelStatus = .ok,
        articles: [NewModel] = []
    ) -> NewsModel {
        return NewsModel(
            status: status,
            totalResults: articles.count,
            articles: articles
        )
    }
}
