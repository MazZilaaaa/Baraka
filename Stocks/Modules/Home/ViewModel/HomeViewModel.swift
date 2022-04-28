//
//  HomeViewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

final class HomeViewModel {
    
    weak var output: HomeOutput?
    
    let mainNewsViewModel: MainNewsListViewModel
    
    init(mainNewsViewModel: MainNewsListViewModel) {
        self.mainNewsViewModel = mainNewsViewModel
    }
    
    func reloadData() {
    }
}

extension HomeViewModel: MainNewsListOutput {
}
