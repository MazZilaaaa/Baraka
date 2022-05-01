//
//  APIError.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

enum APIError: Error {
    case badUrl
    case networkError(error: Error)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badUrl:
            return NSLocalizedString(
                "Check url",
                comment: String(describing: APIError.self)
            )
        case .networkError:
            return NSLocalizedString(
                "Network error",
                comment: String(describing: APIError.self)
            )
        }
    }
}
