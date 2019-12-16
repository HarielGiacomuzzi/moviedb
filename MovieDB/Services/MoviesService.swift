//
//  MoviesService.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol MoviesService: class {
    func fetchNextPage(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}

enum MovieServiceErrors: Error {
    case InvalidCurrentPageNumber
    case InvalidMovieId
    case Unknown(error: Error)
}

class MainMovieService: MoviesService {
    private var provider: MovieProvider!
    private var currentPage: Int = 1
    private var numberOfPages: Int = 1
    private var currentMovies: [Movie] = []

    init(provider: MovieProvider? = MovieDBMoviesProvider(backendService: .QA)) {
        self.provider = provider
    }

    func fetchNextPage(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if currentPage <= numberOfPages {
            provider.getMoviesForPage(
                page: currentPage,
                language: MovieDBLanguages.Portuguese) { result in
                    switch result {
                    case .failure(let error):
                        debugPrint("Could not fetch results from movieDB, details: \(error.localizedDescription)")
                        completion(.failure(MovieServiceErrors.Unknown(error: error)))
                    case .success(let movieDBResponse):
                        self.currentPage += 1
                        self.numberOfPages = movieDBResponse.totalPages
                        self.currentMovies = movieDBResponse.results
                        completion(.success(self.currentMovies))
                    }
            }
        } else {
            completion(.failure(MovieServiceErrors.InvalidCurrentPageNumber))
        }
    }

    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        if movieId > 0 {
            provider.getMovieById(
                id: movieId,
                language: MovieDBLanguages.Portuguese) { result in
                    switch result {
                    case .failure(let error):
                        debugPrint("Could not fetch details of movie: \(error.localizedDescription)")
                        completion(.failure(MovieServiceErrors.Unknown(error: error)))
                    case .success(let movieDetails):
                        completion(.success(movieDetails))
                    }
            }
        } else {
            completion(.failure(MovieServiceErrors.InvalidMovieId))
        }
    }

}
