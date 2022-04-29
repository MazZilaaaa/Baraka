//
//  HomeNewsCellModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation

final class HomeNewsCellModel {
    
    private(set) var newModel: NewModel
    
    init(newModel: NewModel) {
        self.newModel = newModel
    }
}

extension HomeNewsCellModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(newModel)
    }
    
    static func == (lhs: HomeNewsCellModel, rhs: HomeNewsCellModel) -> Bool {
        lhs.newModel == rhs.newModel
    }
}
