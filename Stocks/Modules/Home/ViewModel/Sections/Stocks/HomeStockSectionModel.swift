//
//  HomeStockSectionModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//


struct HomeStockSectionModel: HomeSectionModel {
    let type: HomeSectionModelType = .stocks
    var items: [AnyHashable] = []
}
