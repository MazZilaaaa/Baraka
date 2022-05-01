//
//  AlertPresentable.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 01.05.2022.
//

import UIKit

protocol AlertPresentable: AnyObject {}

extension AlertPresentable where Self: UIViewController {
    func showAlert(
        actionTitle: String,
        title: String? = nil,
        message: String? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let uiAction = UIAlertAction(title: actionTitle, style: .default)
        
        alertController.addAction(uiAction)
        
        present(alertController, animated: true)
    }
}
