//
//  Response.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

struct Response<T: Codable> {
    let data: T
    let response: URLResponse?
    
    init(data: T, response: URLResponse? = nil) {
        self.data = data
        self.response = response
    }
}
