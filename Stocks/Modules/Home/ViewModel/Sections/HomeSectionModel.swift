//
//  HomeSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation

enum HomeSectionModel: Hashable {
    case stocks(items: [HomeStockCellModel])
    case majorNews(items: [HomeMajorNewCellModel])
    case news(items: [HomeNewsCellModel])
}
