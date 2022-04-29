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
        case .news:
            return self.generateNewsLayout()
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
    
    private func generateNewsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupHeight = NSCollectionLayoutDimension.fractionalWidth( 0.5)
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
