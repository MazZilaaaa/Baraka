//
//  HomeViewModelTests.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Combine
import OrderedCollections
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    
    private var newsService: NewsServiceMock!
    private var stocksService: StocksServiceMock!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        newsService = NewsServiceMock()
        stocksService = StocksServiceMock()
        
        viewModel = HomeViewModel(newsService: newsService, stocksService: stocksService)
    }
    
    override func tearDown() {
        viewModel = nil
        
        stocksService = nil
        newsService = nil
        
        super.tearDown()
    }
    
    func test_loadData() {
        // given
        let newsModel: NewsModel = .stub(
            status: .ok,
            articles: [
                .stub()
            ]
        )
        
        let stocks: OrderedDictionary<StockModel, [StockPriceModel]> = [
            .stub() : [.stub()]
        ]
        
        let stocksModel: StocksModel = .stub(stocks: stocks)
        
        newsService.getNewsStub = Result.Publisher(newsModel).eraseToAnyPublisher()
        stocksService.getStocksStub = Result.Publisher(stocksModel).eraseToAnyPublisher()
        
        let expectation = expectation(description: "test_loadData")
        
        var receivedSections: HomeSectionsModel?
        viewModel
            .$sections
            .dropFirst()
            .sink { sections in
                receivedSections = sections
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        
        // when
        viewModel.loadData()
        wait(for: [expectation], timeout: 0.2)
        
        // then
        XCTAssertEqual(receivedSections?.stocksSection?.items.count, 1)
        XCTAssertEqual(receivedSections?.majorNewsSection?.items.count, 1)
        XCTAssertNil(viewModel.sections.newsSection)
        
    }
}
