//
//  MovieDBResponse.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.

import Foundation

// MARK: - MovieDBResponse
class MovieDBResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    init(page: Int, totalResults: Int, totalPages: Int, results: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
class Movie: Codable {
    let popularity: Double
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title, releaseDate: String
    let originalLanguage: String
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview, posterPath: String

    enum CodingKeys: String, CodingKey {
        case popularity, id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
    }

    init(popularity: Double, id: Int, video: Bool, voteCount: Int, voteAverage: Double, title: String, releaseDate: String, originalLanguage: String, originalTitle: String, genreIDS: [Int], backdropPath: String, adult: Bool, overview: String, posterPath: String) {
        self.popularity = popularity
        self.id = id
        self.video = video
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.title = title
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
        self.posterPath = posterPath
    }
}
