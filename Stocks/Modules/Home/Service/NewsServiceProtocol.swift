//
//  NewsServiceProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine

protocol NewsServiceProtocol {
    func getNews() -> AnyPublisher<NewsModel, Error>
}
