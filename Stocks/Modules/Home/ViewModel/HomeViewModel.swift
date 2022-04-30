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
    private let stocksService: StocksServiceProtocol
    
    // MARK: - Output
    
    weak var output: HomeOutput?
    
    // MARK: - Environment
    
    @Published var sections: [HomeSectionModel] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(
        newsService: NewsServiceProtocol,
        stocksService: StocksServiceProtocol
    ) {
        self.newsService = newsService
        self.stocksService = stocksService
    }
    
    func loadData() {
        Publishers.Zip(newsService.getNews(), stocksService.getStocks())
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { [weak self] news, stocks in
                self?.buildSections(newsModels: news, stocksModels: stocks)
            }
            .store(in: &subscriptions)
    }
    
    private func buildSections(newsModels: NewsModel, stocksModels: StocksModel) {
        let stocksItems: [HomeStockCellModel] = stocksModels.stocks.values.compactMap { prices in
            guard let stockPrice = prices.first else {
                return nil
            }
            
            return HomeStockCellModel(stockPriceModel: stockPrice)
        }
        
        let majorNewsItems = newsModels.articles.prefix(6).map {
            HomeMajorNewCellModel(newModel: $0)
        }
        
        let newsItems = newsModels.articles.suffix(from: 6).map {
            HomeNewsCellModel(newModel: $0)
        }
        
        sections = [
            .stocks(items: stocksItems),
            .majorNews(items: majorNewsItems),
            .news(items: newsItems)
        ]
    }
}
