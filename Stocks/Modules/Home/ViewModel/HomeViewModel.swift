//
//  HomeViewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let newsService: NewsServiceProtocol
    
    // MARK: - Output
    
    weak var output: HomeOutput?
    
    // MARK: - Environment
    
    @Published var sections: [HomeSectionModel] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func loadData() {
        newsService
            .getNews()
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { [weak self] news in
                self?.buildSections(news: news)
            }
            .store(in: &subscriptions)
    }
    
    private func buildSections(news: NewsModel) {
        let majorNewsItems = news.articles.prefix(6).map {
            HomeMajorNewCellModel(newModel: $0)
        }
        
        let newsItems = news.articles.suffix(from: 6).map {
            HomeNewsCellModel(newModel: $0)
        }
        
        sections = [
            .majorNews(items: majorNewsItems),
            .news(items: newsItems)
        ]
    }
}
