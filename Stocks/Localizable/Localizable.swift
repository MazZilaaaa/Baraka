//
//  Localizable.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

enum Localizable: String {
    case ok
    case error
}

extension Localizable {
    enum Errors: String {
        case unexpectedData
        case internetConnectionError
        case unknownError
        case badRequest
        case badResponse
        case serverError
    }
}

extension Localizable {
    var localizableString: String {
        NSLocalizedString(rawValue)
    }
}

extension Localizable.Errors {
    var localizableString: String {
        NSLocalizedString(rawValue)
    }
}

func NSLocalizedString(_ key: String) -> String {
    return Foundation.NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
}
