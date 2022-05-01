//
//  NewsModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

enum NewsModelStatus: String, Codable {
    case ok
}

struct NewsModel: Codable {
    let status: NewsModelStatus
    let totalResults: Int
    let articles: [NewModel]
}
