//
//  HomeStockCell.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 30.04.2022.
//

import UIKit

final class HomeStockCell: UICollectionViewCell {
    
    // MARK: - ViewModel
    
    var viewModel: HomeStockCellModel? {
        didSet {
            configure(by: viewModel)
        }
    }
    
    // MARK: - UIControls
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        
        return label
    }()
    
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
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        contentView.addConstraints([
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        priceLabel.text = nil
    }
    
    private func configure(by viewModel: HomeStockCellModel?) {
        guard let viewModel = viewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
    }
}
