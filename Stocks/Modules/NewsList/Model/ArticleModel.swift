//
//  News.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

struct ArticleModel: Codable {
    let source: ArticleSourceModel
    let author: String?
    let title: String?
    let urlToImage: URL?
    let publishedAt: Date
    let description: String
    let content: String
}
