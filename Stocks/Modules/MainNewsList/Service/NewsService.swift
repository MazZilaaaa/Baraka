//
//  NewsService.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine

final class NewsService: NetworkService<ArticlesAPI> {
}

extension NewsService: NewsServiceProtocol {
    func getNews() -> AnyPublisher<NewsModel, Error> {
        return run(.articles)
            .map { response in
                return response.data
            }
            .eraseToAnyPublisher()
    }
}
