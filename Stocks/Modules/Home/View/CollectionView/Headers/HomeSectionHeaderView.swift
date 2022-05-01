//
//  HomeSectionHeaderView.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import UIKit

final class HomeSectionHeaderView: UICollectionReusableView {
    
    // MARK: - ViewModel
    
    var viewModel: HomeSectionModel? {
        didSet {
            configure(by: viewModel)
        }
    }
    
    // MARK: - UIControls
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        addConstraints([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Paddings.xxs),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configure(by viewModel: HomeSectionModel?) {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.type.title
    }
}
