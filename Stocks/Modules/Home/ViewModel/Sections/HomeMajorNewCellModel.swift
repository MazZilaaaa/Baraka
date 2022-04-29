//
//  HomeMajorNewCellModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation

final class HomeMajorNewCellModel {
    
    private(set) var newModel: NewModel
    
    init(newModel: NewModel) {
        self.newModel = newModel
    }
}

extension HomeMajorNewCellModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(newModel)
    }
    
    static func == (lhs: HomeMajorNewCellModel, rhs: HomeMajorNewCellModel) -> Bool {
        lhs.newModel == rhs.newModel
    }
}

