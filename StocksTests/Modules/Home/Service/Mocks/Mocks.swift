//
//  Mocks.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Combine
import Foundation

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
