//
//  Configuration.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var newsURL: URL {
        return try! URL(string: Configuration.value(for: "NEWS_BASE_URL"))!
    }
    
    static var stocksURL: URL {
        return try! URL(string: Configuration.value(for: "STOCKS_BASE_URL"))!
    }
}
