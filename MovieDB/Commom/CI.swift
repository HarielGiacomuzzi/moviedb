//
//  CI.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

struct CI {
    static var MovieDBApiKey: String = "$(\(KeyNames.MovieDBApiKey))"
    static var MovieDBBasePath: String = "$(\(KeyNames.MovieDBBasePath))"
    static var MovieDBOriginalImageBasePath: String = "$(\(KeyNames.MovieDBImageBasePath))"
}
