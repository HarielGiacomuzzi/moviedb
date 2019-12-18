//
//  MovieProvider.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation

protocol MovieProvider: class {
    func getMoviesForPage(page: Int, language: String, completion: @escaping (Result<MovieDBResponse, Error>) -> Void)
    func getMovieById(id: Int, language: String, completion: @escaping (Result<MovieDetail, Error>) -> Void)
    func getImagesForMovieId(id: Int, completion: @escaping (Result<[Backdrop], Error>) -> Void)
}

class MovieDBMoviesProvider: BaseProvider, MovieProvider {
    private var serviceKey: String!
    private var basePath: String!
    private var baseParams: Dictionary<String, String>!

    init(backendService: ServiceType = .QA) {
        switch backendService {
        case .QA:
            serviceKey = Environment.MovieDBQAKey
        case .Production:
            serviceKey = Environment.MovieDBProdKey
        }

        basePath = Environment.MovieDBBasePath
        baseParams = [
            "api_key": serviceKey
        ]
    }

    func getMoviesForPage(page: Int, language: String = MovieDBLanguages.Portuguese, completion: @escaping (Result<MovieDBResponse, Error>) -> Void) {
        var params = baseParams

        params!["language"] = "\(language)"
        params!["page"] = "\(page)"


        callAPI(
            queryString: params,
            urlPath: "\(basePath ?? "")/movie/popular") { res in
                switch res {
                case .failure(let error):
                    debugPrint("There's an error getting movies list: \(error.localizedDescription)")
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(MovieDBResponse.self, from: data)
                        completion(.success(response))
                    } catch let error {
                        debugPrint("There's an error while decoding movieDB response: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
        }
    }

    func getImagesForMovieId(id: Int, completion: @escaping (Result<[Backdrop], Error>) -> Void) {
        let params = baseParams

        callAPI(
            queryString: params,
            urlPath: "\(basePath ?? "")/movie/\(id)/images") { res in
                switch res {
                case .failure(let error):
                    debugPrint("There's an error getting movie images: \(error.localizedDescription)")
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(MovieImage.self, from: data)
                        completion(.success(response.backdrops ?? []))
                    } catch let error {
                        debugPrint("There's an error while decoding movieDB response: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
        }
    }

    func getMovieById(id: Int, language: String = MovieDBLanguages.Portuguese, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        var params = baseParams

        params!["language"] = "\(language)"

        callAPI(
            queryString: params,
            urlPath: "\(basePath ?? "")/movie/\(id)") { res in
                switch res {
                case .failure(let error):
                    debugPrint("There's an error getting movies list: \(error.localizedDescription)")
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(MovieDetail.self, from: data)
                        completion(.success(response))
                    } catch let error {
                        debugPrint("There's an error while decoding movieDB response: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
        }
    }
}
