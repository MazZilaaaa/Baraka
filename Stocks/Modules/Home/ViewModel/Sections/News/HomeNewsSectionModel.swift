//
//  HomeNewsSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

struct HomeNewsSectionModel: HomeSectionModel {
    let type: HomeSectionModelType = .news
    var items: [AnyHashable] = []
}

extension HomeNewsSectionModel: Equatable {
}
