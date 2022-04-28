//
//  NetworkAPI.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

protocol NetworkAPI {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HttpMethod { get }
}
