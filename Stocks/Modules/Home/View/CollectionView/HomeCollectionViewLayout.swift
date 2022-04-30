//
//  HomeCollectionViewLayout.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import Foundation
import UIKit

final class HomeCollectionViewLayout {
    var sections: [HomeSectionModel] = []
    
    var layout: UICollectionViewCompositionalLayout!
    
    init() {
        self.layout = UICollectionViewCompositionalLayout(sectionProvider: createLayout)
    }
    
    private func createLayout(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let sectionLayoutKind = sections[sectionIndex]
        switch (sectionLayoutKind) {
        case .majorNews:
            return self.generateMajorNewsLayout()
        case let .news(items):
            return self.generateNewsLayout(itemsCount: items.count)
        }
    }
    
    private func generateMajorNewsLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Paddings.xxxs,
            leading: Paddings.xxxs,
            bottom: Paddings.xxxs,
            trailing: Paddings.xxxs)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .fractionalWidth(0.67)
            ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func generateNewsLayout(itemsCount: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Paddings.s,
            leading: Paddings.xxxs,
            bottom: Paddings.xxxs,
            trailing: Paddings.xxxs)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(CGFloat(400 * itemsCount))
            ),
            subitem: item,
            count: itemsCount
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
