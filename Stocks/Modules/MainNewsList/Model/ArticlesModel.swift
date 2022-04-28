//
//  ArticlesModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum ArticlesModelStatus: String, Codable {
    case ok
}

struct ArticlesModel: Codable {
    let status: ArticlesModelStatus
    let totalResults: Int
    let articles: [ArticleModel]
}
