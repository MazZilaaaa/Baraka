//
//  HttpClientError.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum NetworkServiceError: Error {
    case badUrl
    case unexpectedData
    case unknownError
    case masterReleased
    case badRequest(error: Error)
    case serverError(error: Error)
}

extension NetworkServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badUrl:
            return NSLocalizedString(
                "Check url",
                comment: String(describing: NetworkServiceError.self)
            )
        case .unexpectedData:
            return NSLocalizedString(
                "Unexpected data",
                comment: String(describing: NetworkServiceError.self)
            )
        case .unknownError:
            return NSLocalizedString(
                "Unknown error",
                comment: String(describing: NetworkServiceError.self)
            )
        case let .badRequest(error):
            return NSLocalizedString(
                "Check your params: \(error.localizedDescription)",
                comment: String(describing: NetworkServiceError.self)
            )
        case let .serverError(error):
            return NSLocalizedString(
                "Server request error: \(error.localizedDescription)",
                comment: String(describing: NetworkServiceError.self)
            )
        case .masterReleased:
            return NSLocalizedString(
                "Service is dealocated",
                comment: String(describing: NetworkServiceError.self)
            )
        }
    }
}

