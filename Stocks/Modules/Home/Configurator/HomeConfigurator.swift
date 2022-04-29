//
//  HomeConfigurator.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation
import UIKit

typealias HomeModule = (viewModel: HomeViewModel, viewController: UIViewController)

final class HomeConfigurator {
    func configure(
        dependencies: DependencyFactoryProtocol,
        output: HomeOutput? = nil
    ) -> HomeModule {
        let vm = HomeViewModel(newsService: dependencies.newsService)
        let vc = HomeViewController(viewModel: vm)
        
        vm.output = output
        
        return (vm, vc)
    }
}
