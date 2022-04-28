//
//  MainNewsViewModel.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import Foundation

enum MainNewsLoadingState {
    case loading
    case ready
}

final class MainNewsListViewModel: ObservableObject {
    
    // MARK: Output
    
    weak var output: MainNewsListOutput?
    
    // MARK: Dependencies
    
    private let newsService: NewsServiceProtocol
    
    // MARK: Environment
    
    @Published private(set) var newsViewModels: [MainNewsCellModel] = []
    @Published private(set) var loadingState: MainNewsLoadingState = .ready
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(
        newsService: NewsServiceProtocol
    ) {
        self.newsService = newsService
    }
}

extension MainNewsListViewModel {
    func loadNews() {
        loadingState = .loading
        newsService
            .getArticles()
            .map { articleResponse in
                return articleResponse.articles.map { articleModel in
                    MainNewsCellModel(articleModel: articleModel)
                }
            }
            .sink { [weak self] completion in
                self?.loadingState = .ready
            } receiveValue: { [weak self] cells in
                self?.newsViewModels = cells
            }
            .store(in: &subscriptions)
    }
}
