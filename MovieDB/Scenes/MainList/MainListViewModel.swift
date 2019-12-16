//
//  MainListViewModel.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol MainListViewModelDelegate {
    func didFetchMovies(error: MovieServiceErrors?)
}

class MainListViewModel {
    private var service: MoviesService!
    var movies: [Movie] = []
    var delegate: MainListViewModelDelegate?

    init(service: MoviesService = MainMovieService()) {
        self.service = service
    }

    func fetchMovies() {
        service.fetchNextPage { result in
            switch result {
            case .success(let movies):
                self.movies.append(contentsOf: movies)
                self.delegate?.didFetchMovies(error: nil)
            case .failure(let error):
                self.delegate?.didFetchMovies(error: error as? MovieServiceErrors)
            }
        }
    }

}
