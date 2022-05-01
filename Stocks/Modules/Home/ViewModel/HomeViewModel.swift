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
    private let sectionsBuilder: HomeSectionBuilderProtocol
    
    // MARK: - Published
    
    @Published var sections: HomeSectionsModel = HomeSectionsModel()
    @Published var error: Error?
    
    // MARK: - Environment
    
    private var subscriptions: Set<AnyCancellable> = []
    private var monitoringStocksToken: AnyCancellable?
    
    init(
        newsService: NewsServiceProtocol,
        stocksService: StocksServiceProtocol,
        sectionsBuilder: HomeSectionBuilderProtocol
    ) {
        self.newsService = newsService
        self.stocksService = stocksService
        self.sectionsBuilder = sectionsBuilder
    }
    
    // MARK: - Monitoring stocks update
    
    func monitoringIsActive() -> Bool {
        monitoringStocksToken != nil
    }
    
    func startMonitoringStocks() {
        monitoringStocksToken = Timer.publish(
            every: 1,
            tolerance: 0.5,
            on: .main,
            in: .default
        )
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                self?.loadStocks()
            })
    }
    
    func stopMonitoringStocks() {
        monitoringStocksToken?.cancel()
        monitoringStocksToken = nil
    }
    
    // MARK: - Load data
    
    func loadData() {
        Publishers.Zip(stocksService.getStocks(), newsService.getNews())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.startMonitoringStocks()
                
                if case let .failure(error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] stocks, news in
                guard let self = self else {
                    return
                }
                
                self.sections = self.buildSections(stocksModels: stocks, newsModels: news)
            }
            .store(in: &subscriptions)
    }
    
    private func loadStocks() {
        stocksService
            .getStocks()
            .sink { _ in
            } receiveValue: { [weak self] stocksModel in
                self?.sections.stocksSection = self?.sectionsBuilder.buildStocksSection(stocksModels: stocksModel.stocks)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Helpers
    
    private func buildSections(stocksModels: StocksModel, newsModels: NewsModel) -> HomeSectionsModel {
        var sections = HomeSectionsModel()
        
        let majorNewsModels = Array(newsModels.articles.prefix(6))
        sections.majorNewsSection = sectionsBuilder.buildMajorNewsSection(newsModels: majorNewsModels)
        
        if newsModels.articles.count > 6 {
            let remainingNews = Array(newsModels.articles.suffix(from: 6))
            sections.newsSection = sectionsBuilder.buildNewsSection(newsModels: remainingNews)
        }
        
        sections.stocksSection = sectionsBuilder.buildStocksSection(stocksModels: stocksModels.stocks)
        
        return sections
    }
}
