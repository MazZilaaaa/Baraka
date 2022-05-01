//
//  HomeSectionModelType.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

enum HomeSectionModelType: Hashable {
    case stocks
    case majorNews
    case news
}

extension HomeSectionModelType {
    var title: String {
        switch self {
        case .stocks:
            return Localizable.Home.stocks.localizableString
        case .majorNews:
            return Localizable.Home.majorNews.localizableString
        case .news:
            return Localizable.Home.news.localizableString
        }
    }
}
