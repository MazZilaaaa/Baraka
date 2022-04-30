//
//  HomeViewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import Foundation
import OrderedCollections

final class HomeViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let newsService: NewsServiceProtocol
    private let stocksService: StocksServiceProtocol
    
    // MARK: - Output
    
    weak var output: HomeOutput?
    
    // MARK: - Environment
    
    @Published var sections: OrderedSet<HomeSectionModel> = []
    
    private var subscriptions: Set<AnyCancellable> = []
    private var monitoringStocksToken: AnyCancellable?
    
    init(
        newsService: NewsServiceProtocol,
        stocksService: StocksServiceProtocol
    ) {
        self.newsService = newsService
        self.stocksService = stocksService
    }
    
    func startMonitoringStocks() {
        monitoringStocksToken = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .default)
                .autoconnect()
                .sink(receiveValue: { [weak self] _ in
                    self?.loadStocks()
                })
    }
    
    func stopMonitoringStocks() {
        monitoringStocksToken?.cancel()
    }
    
    func updateStocks(_ stocksModels: StocksModel) {
        let stocksItems: [HomeStockCellModel] = stocksModels.stocks.values.compactMap { prices in
            guard let stockPrice = prices.randomElement() else {
                return nil
            }
            
            return HomeStockCellModel(stockPriceModel: stockPrice)
        }
        
        sections.append(.stocks(items: stocksItems))
    }
    
    func updateNews(_ newsModels: NewsModel) {
        let majorNewsItems = newsModels.articles.prefix(6).map {
            HomeMajorNewCellModel(newModel: $0)
        }
        
        let newsItems = newsModels.articles.suffix(from: 6).map {
            HomeNewsCellModel(newModel: $0)
        }
        
        sections.append(.majorNews(items: majorNewsItems))
        sections.append(.news(items: newsItems))
    }
    
    func loadData() {
        Publishers.Zip(newsService.getNews(), stocksService.getStocks())
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] news, stocks in
                self?.updateStocks(stocks)
                self?.updateNews(news)
                self?.startMonitoringStocks()
            }
            .store(in: &subscriptions)
    }
    
    func loadStocks() {
        stocksService
            .getStocks()
            .sink { _ in
            } receiveValue: { [weak self] stocksModel in
                self?.updateStocks(stocksModel)
            }
            .store(in: &subscriptions)
    }
}
