//
//  NetworkError.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case unexpectedData
    case internetConnectionError
    case unknownError
    case badResponse(response: URLResponse)
    case badRequest(response: HTTPURLResponse)
    case serverError(response: HTTPURLResponse)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badUrl:
            return NSLocalizedString(
                Localizable.Errors.badUrl.localizableString,
                comment: String(describing: NetworkError.self)
            )
        case .unexpectedData:
            return NSLocalizedString(
                Localizable.Errors.unexpectedData.localizableString,
                comment: String(describing: NetworkError.self)
            )
        case .internetConnectionError:
            return NSLocalizedString(
                Localizable.Errors.internetConnectionError.localizableString,
                comment: String(describing: NetworkError.self)
            )
        case .unknownError:
            return NSLocalizedString(
                Localizable.Errors.unknownError.localizableString,
                comment: String(describing: NetworkError.self)
            )
        case let .badRequest(response):
            return NSLocalizedString(
                "\(Localizable.Errors.badRequest.localizableString) \(response.debugDescription)",
                comment: String(describing: NetworkError.self)
            )
        case let .serverError(response):
            return NSLocalizedString(
                "\(Localizable.Errors.serverError.localizableString) \(response.debugDescription)",
                comment: String(describing: NetworkError.self)
            )
        case .badResponse(response: let response):
            return NSLocalizedString(
                "\(Localizable.Errors.badResponse) \(response.debugDescription)",
                comment: String(describing: NetworkError.self)
            )
        }
    }
}

