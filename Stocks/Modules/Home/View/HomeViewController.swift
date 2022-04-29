//
//  HomeViewController.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import Combine
import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - ViewModel
    
    private let viewModel: HomeViewModel
    
    // MARK: - UIControls
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout.layout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeMajorNewCell.self, forCellWithReuseIdentifier: HomeMajorNewCell.identifier)
        collectionView.register(HomeNewsCell.self, forCellWithReuseIdentifier: HomeNewsCell.identifier)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        bindViewModel()
        
        viewModel.loadData()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        let leftConstraint = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let topConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let rightConstraint = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        view.addConstraints([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
    }
    
    private func bindViewModel() {
        viewModel
            .$sections
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] sections in
                guard let self = self else {
                    return
                }
                
                self.collectionViewLayout.sections = sections
                self.collectionViewDataSource.sections = sections
            })
            .store(in: &subscriptions)
    }
}
