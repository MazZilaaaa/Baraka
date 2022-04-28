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
        let mainNewsListModule = MainNewsListConfigurator().configure(
            dependencies: dependencies,
            output: nil
        )
        
        let vm = HomeViewModel(mainNewsViewModel: mainNewsListModule.viewModel)
        let vc = HomeViewController(viewModel: vm)
        
        mainNewsListModule.viewModel.output = vm
        vm.output = output
        
        vc.mainNewsViewController = mainNewsListModule.viewController
        
        return (vm, vc)
    }
}
