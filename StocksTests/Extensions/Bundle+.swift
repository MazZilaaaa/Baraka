//
//  Bundle+.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Foundation

private final class BundleDetector {
    var currentBundle: Bundle {
        return Bundle(for: type(of: self))
    }
}

extension Bundle {
    static var testBundle: Bundle {
        return BundleDetector().currentBundle
    }
}
