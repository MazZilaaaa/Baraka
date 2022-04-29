//
//  HomeCollectionViewDecorator.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import UIKit

final class HomeCollectionViewLayoutBuilder {
    var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Paddings.xxs,
            leading: Paddings.xxs,
            bottom: Paddings.s,
            trailing: Paddings.xxs
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
}
