//
//  StocksServiceTests.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Combine
import XCTest
@testable import Stocks

enum NewsServiceTestsError: Error {
    case testError
}

final class NewsServiceTests: XCTestCase {
    var service: NewsServiceProtocol!
    
    var networkProvider: NetworkProviderMock!
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        networkProvider = NetworkProviderMock()
        
        service = NewsService(
            networkProvider: networkProvider
        )
    }
    
    override func tearDown() {
        service = nil
        
        networkProvider = nil
        
        super.tearDown()
    }
    
    func test_getNews() {
        // given
        let response = Response(data: NewsData.newsList.data)
        networkProvider.fetchStub = Result.Publisher(response).eraseToAnyPublisher()
        
        let expectation = expectation(description: "test_getNews")
        
        var receivedNewsModel: NewsModel?
        var receivedCompletion: Subscribers.Completion<Error>?
        
        // when
        service
            .getNews()
            .sink { completion in
                receivedCompletion = completion
                expectation.fulfill()
            } receiveValue: { newsModel in
                receivedNewsModel = newsModel
            }
            .store(in: &subscriptions)
        
        
        wait(for: [expectation], timeout: 0.2)
        
        // then
        XCTAssertEqual(receivedNewsModel?.totalResults, 3)
        XCTAssertEqual(receivedNewsModel?.status, .ok)
        
        guard case .finished = receivedCompletion else {
            XCTFail("completion should be .finished")
            return
        }
    }
    
    func test_getNews_networkError() {
        // given
        networkProvider.fetchStub = Result.Publisher(NewsServiceTestsError.testError).eraseToAnyPublisher()
        
        let expectation = expectation(description: "test_getStocks_networkError")
        
        var receivedCompletion: Subscribers.Completion<Error>?
        
        // when
        service
            .getNews()
            .sink { completion in
                receivedCompletion = completion
                expectation.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &subscriptions)
        
        
        wait(for: [expectation], timeout: 0.2)
        guard case let .failure(error) = receivedCompletion else {
            XCTFail("completion should be .failure")
            return
        }
        
        guard
            let testError = error as? NewsServiceTestsError,
            testError == NewsServiceTestsError.testError else {
            XCTFail("completion should be NewsServiceTestsError.testError")
            return
        }
    }
}
