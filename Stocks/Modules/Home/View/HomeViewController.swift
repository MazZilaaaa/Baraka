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
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeMajorNewCell.self, forCellWithReuseIdentifier: HomeMajorNewCell.identifier)
        collectionView.register(HomeNewsCell.self, forCellWithReuseIdentifier: HomeNewsCell.identifier)
        
        return collectionView
    }()
    
    lazy var dataSource: HomeDataSource = {
        return HomeDataSource(collectionView: collectionView)
    }()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
                self?.dataSource.sections = sections
            })
            .store(in: &subscriptions)
    }
}
