//
//  HomeSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation

enum HomeSectionModelType: Hashable {
    case stocks
    case majorNews
    case news
}

protocol HomeSectionModel {
    var type: HomeSectionModelType { get }
    var items: [AnyHashable] { get set }
}

struct HomeStockSectionModel: HomeSectionModel {
    let type: HomeSectionModelType = .stocks
    var items: [AnyHashable] = []
}

struct HomeMajorNewsSectionModel: HomeSectionModel {
    let type: HomeSectionModelType = .majorNews
    var items: [AnyHashable] = []
}

struct HomeNewsSectionModel: HomeSectionModel {
    let type: HomeSectionModelType = .news
    var items: [AnyHashable] = []
}

struct HomeSectionsModel {
    var stocksSection: HomeStockSectionModel?
    var majorNewsSection: HomeMajorNewsSectionModel?
    var newsSection: HomeNewsSectionModel?
    
    var allSections: [HomeSectionModel] {
        var result: [HomeSectionModel] = []
        
        if let stocksSection = stocksSection {
            result.append(stocksSection)
        }
        
        if let majorNewsSection = majorNewsSection {
            result.append(majorNewsSection)
        }
        
        if let newsSection = newsSection {
            result.append(newsSection)
        }
        
        return result
    }
}
