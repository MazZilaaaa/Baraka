//
//  HomeViewModelTests.swift
//  StocksTests
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

@testable import Stocks

import Combine
import XCTest

enum HomeViewModelTestsError: Error {
    case testError
}

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    
    private var newsService: NewsServiceMock!
    private var stocksService: StocksServiceMock!
    private var sectionBuilder: HomeSectionBuilderMock!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        newsService = NewsServiceMock()
        stocksService = StocksServiceMock()
        sectionBuilder = HomeSectionBuilderMock()
        
        viewModel = HomeViewModel(
            newsService: newsService,
            stocksService: stocksService,
            sectionsBuilder: sectionBuilder
        )
    }
    
    override func tearDown() {
        viewModel = nil
        
        stocksService = nil
        newsService = nil
        
        super.tearDown()
    }
    
    func test_loadData() {
        // given
        let stockModel: [StockModel] = [
            .stub()
        ]
        
        let news: [NewModel] = [
            .stub(),
            .stub(),
            .stub(),
            .stub(),
            .stub(),
            .stub(),
            .stub(),
        ]
        
        let stocksModel: StocksModel = .stub(stocks: stockModel)
        let newsModel: NewsModel = .stub(articles: news)
        
        stocksService.getStocksStub = Result.Publisher(stocksModel).eraseToAnyPublisher()
        newsService.getNewsStub = Result.Publisher(newsModel).eraseToAnyPublisher()
        
        sectionBuilder.stocksSectionStub = HomeStockSectionModel()
        sectionBuilder.majorNewsSectionStub = HomeMajorNewsSectionModel()
        sectionBuilder.newsSectionStub = HomeNewsSectionModel()
        
        let expectation = expectation(description: "test_loadData")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        
        // when
        viewModel.loadData()
        wait(for: [expectation], timeout: 0.2)
        
        // then
        XCTAssertEqual(sectionBuilder.receivedStocksModel?.count, 1)
        XCTAssertEqual(sectionBuilder.receivedMajorNewsModel?.count, 6)
        XCTAssertEqual(sectionBuilder.receivedNewsModel?.count, 1)
        
        XCTAssertEqual(viewModel.sections.stocksSection, sectionBuilder.stocksSectionStub)
        XCTAssertEqual(viewModel.sections.majorNewsSection, sectionBuilder.majorNewsSectionStub)
        XCTAssertEqual(viewModel.sections.newsSection, sectionBuilder.newsSectionStub)
    }
    
    func test_loadData_failed() {
        // given
        stocksService.getStocksStub = Result.Publisher(HomeViewModelTestsError.testError).eraseToAnyPublisher()
        newsService.getNewsStub = Result.Publisher(HomeViewModelTestsError.testError).eraseToAnyPublisher()
        
        sectionBuilder.stocksSectionStub = HomeStockSectionModel()
        
        let expectation = expectation(description: "test_loadData_failed")
        
        viewModel
            .$error
            .dropFirst()
            .sink { error in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        
        // when
        viewModel.loadData()
        wait(for: [expectation], timeout: 0.2)
        
        // then
        XCTAssertNil(sectionBuilder.receivedStocksModel)
        XCTAssertNil(sectionBuilder.receivedMajorNewsModel)
        XCTAssertNil(sectionBuilder.receivedNewsModel)
        
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_startMonitoringStocks() {
        // given
        let stockModel: [StockModel] = [
            .stub()
        ]
        
        let stocksModel: StocksModel = .stub(stocks: stockModel)
        stocksService.getStocksStub = Result.Publisher(stocksModel).eraseToAnyPublisher()
        sectionBuilder.stocksSectionStub = HomeStockSectionModel()
        
        let expectation = expectation(description: "test_startMonitoringStocks")
        
        // when
        viewModel.startMonitoringStocks()
        
        viewModel
            .$sections
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertNotNil(viewModel.sections.stocksSection)
        XCTAssertEqual(viewModel.sections.stocksSection, sectionBuilder.stocksSectionStub)
    }
    
    func test_stopMonitoringStocks() {
        
        // when
        viewModel.startMonitoringStocks()
        viewModel.stopMonitoringStocks()
        
        // then
        XCTAssertFalse(viewModel.monitoringIsActive())
    }
}
