//
//  MainNewsListConfigurator.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation
import UIKit

typealias MainNewsListModule = (viewModel: MainNewsListViewModel, viewController: UIViewController)

final class MainNewsListConfigurator {
    func configure(
        dependencies: DependencyFactoryProtocol,
        output: MainNewsListOutput? = nil
    ) -> MainNewsListModule {
        let vm = MainNewsListViewModel(
            newsService: dependencies.newsService
        )
        
        let vc = MainNewsListViewController(viewModel: vm)
        
        vm.output = output
        
        return (vm, vc)
    }
}
