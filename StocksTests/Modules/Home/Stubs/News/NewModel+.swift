//
//  NewModel+.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Foundation

extension NewModel {
    static func stub(
        source: NewSourceModel = NewSourceModel(id: "id", name: "name"),
        author: String? = "author",
        title: String? = "title",
        urlToImage: URL? = nil,
        publishedAt: Date = Date(),
        description: String = "description",
        content: String = "content"
    ) -> NewModel {
        return NewModel(
            source: source,
            author: author,
            title: title,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            description: description,
            content: content
        )
    }
}
