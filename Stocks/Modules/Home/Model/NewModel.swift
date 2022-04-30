//
//  NewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

struct NewModel: Codable, Hashable {
    let source: NewSourceModel
    let author: String?
    let title: String?
    let urlToImage: URL?
    let publishedAt: Date
    let description: String
    let content: String
}
