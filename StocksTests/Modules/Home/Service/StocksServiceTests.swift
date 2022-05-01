//
//  StocksServiceTests.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import Combine
import XCTest
@testable import Stocks

enum StocksServiceTestsError: Error {
    case testError
}

final class StocksServiceTests: XCTestCase {
    var service: StocksServiceProtocol!
    
    var networkProvider: NetworkProviderMock!
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        networkProvider = NetworkProviderMock()
        
        service = StocksService(
            networkProvider: networkProvider
        )
    }
    
    override func tearDown() {
        service = nil
        
        networkProvider = nil
        
        super.tearDown()
    }
    
    func test_getStocks() {
        // given
        let response = Response(data: StocksData.stocksList.data)
        networkProvider.fetchStub = Result.Publisher(response).eraseToAnyPublisher()
        
        let expectation = expectation(description: "test_getStocks")
        
        var receivedStocksModel: StocksModel?
        var receivedCompletion: Subscribers.Completion<Error>?
        
        // when
        service
            .getStocks()
            .sink { completion in
                receivedCompletion = completion
                expectation.fulfill()
            } receiveValue: { stocksModel in
                receivedStocksModel = stocksModel
            }
            .store(in: &subscriptions)
        
        
        wait(for: [expectation], timeout: 0.2)
        
        // then
        XCTAssertEqual(receivedStocksModel?.stocks.count, 3)
        guard case .finished = receivedCompletion else {
            XCTFail("completion should be .finished")
            return
        }
    }
    
    func test_getStocks_networkError() {
        // given
        networkProvider.fetchStub = Result.Publisher(StocksServiceTestsError.testError).eraseToAnyPublisher()
        
        let expectation = expectation(description: "test_getStocks_networkError")
        
        var receivedCompletion: Subscribers.Completion<Error>?
        
        // when
        service
            .getStocks()
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
            let testError = error as? StocksServiceTestsError,
            testError == StocksServiceTestsError.testError else {
            XCTFail("completion should be StocksServiceTestsError.testError")
            return
        }
    }
}
