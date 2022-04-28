//
//  Response.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

struct Response<T> {
    let data: T
    let response: URLResponse
}
