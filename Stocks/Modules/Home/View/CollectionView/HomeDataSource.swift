//
//  HomeDataSource.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation
import UIKit

final class HomeDataSource {
    var sections: [HomeSectionModel] {
        didSet {
            reloadSections(sections)
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSectionModel, AnyHashable>!
    
    init(collectionView: UICollectionView) {
        self.sections = []
        self.dataSource = UICollectionViewDiffableDataSource<HomeSectionModel, AnyHashable>(
            collectionView: collectionView,
            cellProvider: createCell
        )
        
        self.dataSource.supplementaryViewProvider = createSupplementaryView
    }
    
    private func reloadSections(_ sections: [HomeSectionModel]) {
        let snapshot = createSnapshot(sections: sections)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createCell(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: AnyHashable) -> UICollectionViewCell? {
        var cell: UICollectionViewCell?
        switch sections[indexPath.section] {
        case .majorNews:
            let majorNewsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeMajorNewCell.identifier,
                for: indexPath
            ) as? HomeMajorNewCell
            
            majorNewsCell?.viewModel = itemIdentifier as? HomeMajorNewCellModel
            cell = majorNewsCell
            
        case .news:
            let newsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeNewsCell.identifier,
                for: indexPath
            ) as? HomeNewsCell
            
            newsCell?.viewModel = itemIdentifier as? HomeNewsCellModel
            cell = newsCell
        }
        
        return cell
    }
    
    private func createSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
    
    private func createSnapshot(sections: [HomeSectionModel]) -> NSDiffableDataSourceSnapshot<HomeSectionModel, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSectionModel, AnyHashable>()
        
        sections.forEach { section in
            snapshot.appendSections([section])
            switch section {
            case let .majorNews(items):
                snapshot.appendItems(items)
            case let .news(items):
                snapshot.appendItems(items)
            }
        }
        
        return snapshot
    }
}
