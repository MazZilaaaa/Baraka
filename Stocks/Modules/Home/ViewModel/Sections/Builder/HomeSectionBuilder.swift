//
//  HomeSectionBuilder.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

final class HomeSectionBuilder {
}

extension HomeSectionBuilder: HomeSectionBuilderProtocol {
    func buildMajorNewsSection(newsModels: [NewModel]) -> HomeMajorNewsSectionModel {
        let majorNewsItems = newsModels.map {
            HomeMajorNewCellModel(newModel: $0)
        }
        
        return HomeMajorNewsSectionModel(items: majorNewsItems)
    }
    
    func buildNewsSection(newsModels: [NewModel]) -> HomeNewsSectionModel {
        let newsItems = newsModels.map {
            HomeNewsCellModel(newModel: $0)
        }
        
        return HomeNewsSectionModel(items: newsItems)
    }
    
    func buildStocksSection(stocksModels: [StockModel]) -> HomeStockSectionModel {
        let stocksItems: [HomeStockCellModel] = stocksModels.compactMap { stockModel in
            guard let stockPrice = stockModel.prices.randomElement() else {
                return nil
            }
            
            return HomeStockCellModel(stockPriceModel: stockPrice)
        }
        
        return HomeStockSectionModel(items: stocksItems)
    }
}
