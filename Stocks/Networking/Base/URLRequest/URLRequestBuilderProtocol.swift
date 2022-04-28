//
//  URLRequestBuilderProtocol.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

protocol URLRequestBuilderProtocol {
    func buildRequest(_ api: NetworkAPI) -> URLRequest?
}
