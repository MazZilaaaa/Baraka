//
//  HomeSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

protocol HomeSectionModel {
    var type: HomeSectionModelType { get }
    var items: [AnyHashable] { get set }
}

struct HomeSectionsModel {
    var stocksSection: HomeStockSectionModel?
    var majorNewsSection: HomeMajorNewsSectionModel?
    var newsSection: HomeNewsSectionModel?
    
    var orderedSections: [HomeSectionModel] {
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
