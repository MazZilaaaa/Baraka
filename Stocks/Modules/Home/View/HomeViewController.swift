//
//  HomeViewController.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 28.04.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - ViewModel
    
    private let viewModel: HomeViewModel
    
    // MARK: - UIControls
    
    var mainNewsViewController: UIViewController?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        if let mainNewsView = mainNewsViewController?.view {
            mainNewsView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
            view.addSubview(mainNewsView)
        }
    }
}
