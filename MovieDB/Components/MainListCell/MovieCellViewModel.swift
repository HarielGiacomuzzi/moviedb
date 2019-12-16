//
//  MovieCellViewModel.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

class MovieCellViewModel {

    let movieTitle: String!
    let movieDescription: String!
    let movieRating: String!
    let movieYear: String!
    let moviePosterPath: String!
    let movieRatingValue: Double!


    init(with movie: Movie) {
        movieTitle = movie.title
        movieDescription = movie.overview
        movieRating = movie.voteAverage.description
        movieYear = movie.releaseDate.prefix(4).description
        moviePosterPath = movie.posterPath
        movieRatingValue = movie.voteAverage
    }
}
