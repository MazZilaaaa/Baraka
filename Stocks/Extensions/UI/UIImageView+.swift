//
//  UIImageView+.swift
//  Stocks
//
//  Created by Aleksandr Fadeev on 29.04.2022.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
