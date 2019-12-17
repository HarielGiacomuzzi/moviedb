//
//  UIView+RoudedCorners.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 17/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func makeRoundedCorners(radious: CGFloat) {
        self.layer.cornerRadius = radious
        self.layer.masksToBounds = true
    }
}
