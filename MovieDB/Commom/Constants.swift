//
//  Constants.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

enum ServiceType {
    case Production
    case QA
}

struct MovieDBLanguages {
    static let Portuguese = "pt-BR"
}

struct CellIdentifiers {
    static let MainListCell = "movieCell"
}

struct SegueIdentifiers {
    static let GotoDetail = "showDetail"
}

struct KeyNames {
    static let MovieDBApiKey = "MOVIE_DB_API_KEY"
    static let MovieDBBasePath = "MOVIE_DB_BASE_PATH"
    static let MovieDBImageBasePath = "MOVIE_DB_IMAGE_BASE_PATH"
}

struct Environment {

    //MARK: QA Keys
    static var MovieDBQAKey: String = Environment.variable(named: KeyNames.MovieDBApiKey) ?? CI.MovieDBApiKey

    //MARK: Production Keys
    static var MovieDBProdKey: String = ""

    //MARK: Commom Values
    static var MovieDBBasePath: String = Environment.variable(named: KeyNames.MovieDBBasePath) ?? CI.MovieDBBasePath
    static var MovieDBOriginalImageBasePath: String = Environment.variable(named: KeyNames.MovieDBImageBasePath) ?? CI.MovieDBOriginalImageBasePath

    static func variable(named name: String) -> String? {
        let processInfo = ProcessInfo.processInfo
        guard let value = processInfo.environment[name] else {
            return nil
        }
        return value
    }
}

