//
//  Mocks.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Combine
import Foundation

final class HomeSectionBuilderMock: HomeSectionBuilderProtocol {
    
    var stocksSectionStub: HomeStockSectionModel!
    var receivedStocksModel: [StockModel]?
    var buildStocksSectionCalled = false
    
    func buildStocksSection(stocksModels: [StockModel]) -> HomeStockSectionModel {
        receivedStocksModel = stocksModels
        return stocksSectionStub
    }
    
    var majorNewsSectionStub: HomeMajorNewsSectionModel!
    var receivedMajorNewsModel: [NewModel]?
    var buildMajorNewsSectionCalled = false
    
    func buildMajorNewsSection(newsModels: [NewModel]) -> HomeMajorNewsSectionModel {
        receivedMajorNewsModel = newsModels
        
        return majorNewsSectionStub
    }
    
    var newsSectionStub: HomeNewsSectionModel!
    var receivedNewsModel: [NewModel]?
    var buildNewsSectionCalled = false
    
    func buildNewsSection(newsModels: [NewModel]) -> HomeNewsSectionModel {
        receivedNewsModel = newsModels
        
        return newsSectionStub
    }
}

final class NewsServiceMock: NewsServiceProtocol {
    
    var getNewsStub: AnyPublisher<NewsModel, Error>!
    
    func getNews() -> AnyPublisher<NewsModel, Error> {
        return getNewsStub
    }
}

final class StocksServiceMock: StocksServiceProtocol {
    
    var getStocksStub: AnyPublisher<StocksModel, Error>!
    
    func getStocks() -> AnyPublisher<StocksModel, Error> {
        return getStocksStub
    }
}


final class URLRequestBuilderMock: URLRequestBuilderProtocol {
    
    var receivedAPI: NetworkAPI?
    var buildRequestStub: URLRequest?
    
    func buildRequest(_ api: NetworkAPI) -> URLRequest? {
        receivedAPI = api
        
        return buildRequestStub
    }
}

final class NetworkProviderMock: NetworkProviderProtocol {
    
    var receivedRequest: URLRequest?
    var fetchStub: AnyPublisher<Response<Data>, Error>!
    
    func fetch(from request: URLRequest) -> AnyPublisher<Response<Data>, Error> {
        receivedRequest = request
        
        return fetchStub
    }
}
