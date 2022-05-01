//
//  NumberFormatters.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import Foundation

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.US
        
        return currencyFormatter
    }
}
