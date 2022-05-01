//
//  HomeViewController.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import UIKit

final class HomeViewController: UIViewController, AlertPresentable {
    
    // MARK: - ViewModel
    
    private let viewModel: HomeViewModel
    
    // MARK: - UIControls
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControllChanged), for: .valueChanged)
        
        return refreshControl
    }()
    
    // in production projects better do skeleton view
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .medium
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout.layout
        )
        
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeStockCell.self, forCellWithReuseIdentifier: HomeStockCell.identifier)
        collectionView.register(HomeMajorNewCell.self, forCellWithReuseIdentifier: HomeMajorNewCell.identifier)
        collectionView.register(HomeNewsCell.self, forCellWithReuseIdentifier: HomeNewsCell.identifier)
        collectionView.register(
            HomeSectionHeaderView.self,
            forSupplementaryViewOfKind: HomeSectionHeaderView.identifier,
            withReuseIdentifier: HomeSectionHeaderView.identifier
        )
        
        return collectionView
    }()
    
    lazy var collectionViewDataSource: HomeCollectonViewDataSource = {
        return HomeCollectonViewDataSource(collectionView: collectionView)
    }()
    
    lazy var collectionViewLayout: HomeCollectionViewLayout = {
        return HomeCollectionViewLayout()
    }()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleRefreshControllChanged() {
        viewModel.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        bindViewModel()
        
        viewModel.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.stopMonitoringStocks()
        
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel
            .$sections
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] sections in
                guard let self = self else {
                    return
                }
                
                self.refreshControl.endRefreshing()
                self.loadingIndicator.stopAnimating()
                
                self.collectionViewLayout.sectionsModel = sections
                self.collectionViewDataSource.sectionsModel = sections
            })
            .store(in: &subscriptions)
        
        viewModel
            .$error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                guard let error = error else {
                    return
                }
                
                self?.showAlert(actionTitle: Localizable.ok.rawValue, message: error.localizedDescription)
            })
            .store(in: &subscriptions)
    }
}
