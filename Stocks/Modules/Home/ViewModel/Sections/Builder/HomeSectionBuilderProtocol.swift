//
//  HomeSectionBuilderProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

protocol HomeSectionBuilderProtocol {
    func buildMajorNewsSection(newsModels: [NewModel]) -> HomeMajorNewsSectionModel
    func buildNewsSection(newsModels: [NewModel]) -> HomeNewsSectionModel
    func buildStocksSection(stocksModels: [StockModel]) -> HomeStockSectionModel
}
