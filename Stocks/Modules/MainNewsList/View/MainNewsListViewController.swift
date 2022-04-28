//
//  MainNewsListViewController.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

final class MainNewsListViewController: UIViewController {
    
    // MARK: - ViewModel
    
    private let viewModel: MainNewsListViewModel
    
    init(viewModel: MainNewsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
