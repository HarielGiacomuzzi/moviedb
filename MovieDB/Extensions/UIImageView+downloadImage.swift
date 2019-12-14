//
//  UIImage+downloadImage.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        guard let urlFromString = URL(string: url) else { return }
        downloadImage(from: urlFromString)
    }

    func downloadImage(from url: URL) {
        ImageCache.downloadImage(url: url) { image in
            self.image = image
        }
    }
}
