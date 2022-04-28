//
//  ModulesFactoryProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

protocol ModulesFactoryProtocol {
    func createHome(output: HomeOutput?) -> HomeModule
    func createMainNewsList(output: MainNewsListOutput?) -> MainNewsListModule
}
