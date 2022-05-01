//
//  HomeDataSource.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import UIKit

final class HomeCollectonViewDataSource {
    var sectionsModel: HomeSectionsModel = HomeSectionsModel() {
        didSet {
            reloadSections(sectionsModel)
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSectionModelType, AnyHashable>!
    
    init(collectionView: UICollectionView) {
        self.dataSource = UICollectionViewDiffableDataSource<HomeSectionModelType, AnyHashable>(
            collectionView: collectionView,
            cellProvider: createCell
        )
        
        self.dataSource.supplementaryViewProvider = createSupplementaryView
    }
    
    private func reloadSections(_ sectionsModel: HomeSectionsModel?) {
        guard let sectionsModel = sectionsModel else {
            return
        }
        
        let snapshot = createSnapshot(sectionsModel: sectionsModel)
         dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    private func createCell(collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: AnyHashable) -> UICollectionViewCell? {
        var cell: UICollectionViewCell?
        switch sectionsModel.orderedSections[indexPath.section].type {
        case .stocks:
            let stockCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeStockCell.identifier,
                for: indexPath
            ) as? HomeStockCell
            
            stockCell?.viewModel = itemIdentifier as? HomeStockCellModel
            cell = stockCell
            
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
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeSectionHeaderView.identifier,
            for: indexPath) as? HomeSectionHeaderView
        
        supplementaryView?.viewModel = sectionsModel.orderedSections[indexPath.section]
        
        return supplementaryView
    }
    
    private func createSnapshot(sectionsModel: HomeSectionsModel) -> NSDiffableDataSourceSnapshot<HomeSectionModelType, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSectionModelType, AnyHashable>()
        
        sectionsModel.orderedSections.forEach { section in
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.items)
        }
        
        return snapshot
    }
}
