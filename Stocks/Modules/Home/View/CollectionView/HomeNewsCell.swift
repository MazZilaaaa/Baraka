//
//  HomeNewsCell.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import UIKit

final class HomeNewsCell: UICollectionViewCell {
    
    var viewModel: HomeNewsCellModel? {
        didSet {
            configure(by: viewModel)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .blue
    }
    
    private func setupLayout() {
    }
    
    private func configure(by viewModel: HomeNewsCellModel?) {
        guard let viewModel = viewModel else {
            return
        }
    }
}
