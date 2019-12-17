//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func didFetchMovieDetails(error: MovieServiceErrors?)
}

class MovieDetailViewModel {
    var movieInfo: MovieDetail? {
        didSet {
            delegate?.didFetchMovieDetails(error: nil)
        }
    }

    var movieId: Int?
    var delegate: MovieDetailViewModelDelegate?

    private var service: MoviesService!


    init(service: MoviesService = MainMovieService()) {
        self.service = service
    }

    func fetchMovieDetail() {
        guard let id = movieId else { return }
        service.fetchMovieDetail(movieId: id) { resp in
            switch resp {
            case .success(let movie):
                self.movieInfo = movie
            case .failure(let error):
                self.delegate?.didFetchMovieDetails(error: error as? MovieServiceErrors)
            }
        }
    }
}
