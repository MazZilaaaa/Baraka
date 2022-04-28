//
//  HttpClientError.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum HttpClientError: Error {
    case badUrl
    case unexpectedData
    case unknownError
    case badRequest(error: Error)
    case serverError(error: Error)
}
