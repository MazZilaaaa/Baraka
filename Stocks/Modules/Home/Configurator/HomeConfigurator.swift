//
//  HomeConfigurator.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

typealias HomeModule = (viewModel: HomeViewModel, viewController: UIViewController)

final class HomeConfigurator {
    func configure(
        dependencies: DependencyFactoryProtocol
    ) -> HomeModule {
        let vm = HomeViewModel(
            newsService: dependencies.newsService,
            stocksService: dependencies.stocksService,
            sectionsBuilder: HomeSectionBuilder()
        )
        
        let vc = HomeViewController(viewModel: vm)
        
        return (vm, vc)
    }
}
