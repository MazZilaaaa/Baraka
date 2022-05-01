//
//  MajorCollectionViewCell.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import UIKit

final class HomeMajorNewCell: UICollectionViewCell {
    
    // MARK: - ViewModel
    
    var viewModel: HomeMajorNewCellModel? {
        didSet {
            configure(by: viewModel)
        }
    }
    
    // MARK: - UIControls
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
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
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        contentView.addConstraints([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Paddings.xxs),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Paddings.xxs),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Paddings.xxs)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        imageView.image = nil
        imageView.cancelImageLoad()
    }
    
    private func configure(by viewModel: HomeMajorNewCellModel?) {
        guard let viewModel = viewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        if let image = viewModel.image {
            imageView.loadImage(at: image)
        } else {
            imageView.image = UIImage(systemName: "photo.circle")
        }
    }
}
