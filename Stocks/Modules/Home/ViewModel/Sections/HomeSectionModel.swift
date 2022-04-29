//
//  HomeSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation

enum HomeSectionModel: Hashable {
    case majorNews(items: [HomeMajorNewCellModel])
    case news(items: [HomeNewsCellModel])
}
