//
//  NewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

struct NewModel: Codable, Hashable {
    internal init(source: NewSourceModel, author: String?, title: String?, urlToImage: URL?, publishedAt: Date, description: String, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.description = description
        self.content = content
    }
    
    let source: NewSourceModel
    let author: String?
    let title: String?
    let urlToImage: URL?
    let publishedAt: Date
    let description: String
    let content: String
}
