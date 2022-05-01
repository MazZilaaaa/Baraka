//
//  DateFormatter+.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Foundation

extension DateFormatter {
    static var nonStandardDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return dateFormatter
    }
    
    static var fullDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.US
        dateFormatter.setLocalizedDateFormatFromTemplate("ddMMMMyyyy")
        
        return dateFormatter
    }
}
