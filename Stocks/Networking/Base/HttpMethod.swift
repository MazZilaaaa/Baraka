//
//  HttpMethod.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum HttpMethod {
    case get
    case post
    
    var urlSessionMethod: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
