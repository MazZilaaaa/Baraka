//
//  NewsService.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine

final class NewsService: NetworkService<NewsAPI> {
}

extension NewsService: NewsServiceProtocol {
    func getNews() -> AnyPublisher<ArticlesModel, Error> {
        return run(.news)
            .map { response in
                return response.data
            }
            .eraseToAnyPublisher()
    }
}
