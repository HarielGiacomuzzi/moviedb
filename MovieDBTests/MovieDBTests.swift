//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Hariel Giacomuzzi on 14/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBTests: XCTestCase {
    var provider: MovieProvider!
    var service: MoviesService!

    override func setUp() {
        provider = MovieDBMoviesProvider(backendService: .QA)
        service = MainMovieService(provider: provider)
    }

    override func tearDown() {
        provider = nil
        service = nil
    }

    func testProviderFetchMovies() {
        let expectation = XCTestExpectation(description: "Wait for provider fetch movies response")
        expectation.expectedFulfillmentCount = 1

        provider.getMoviesForPage(page: 1, language: MovieDBLanguages.Portuguese) { result in
            switch result {
            case.failure(let error):
                expectation.fulfill()
                XCTAssertTrue(false, "Encounter an error: \(error.localizedDescription)")
            case .success(let movies):
                expectation.fulfill()
                XCTAssertGreaterThan(movies.results.count, 0)
            }
        }

        wait(for: [expectation], timeout: 15.0)
    }

    func testProviderFetchMoviesInvalidPage() {
        let expectation = XCTestExpectation(description: "Wait for provider fetch movies response")
        expectation.expectedFulfillmentCount = 1

        provider.getMoviesForPage(page: -1, language: MovieDBLanguages.Portuguese) { result in
            switch result {
            case.failure(let error):
                expectation.fulfill()
                XCTAssertTrue(true, "Encounter an expected error: \(error.localizedDescription)")
            case .success:
                expectation.fulfill()
                XCTAssertTrue(false, "Encounter an Unexpected page")
            }
        }

        wait(for: [expectation], timeout: 15.0)
    }

    func testServiceFetchMovies() {
        let expectation = XCTestExpectation(description: "Wait for service fetch movies response")
        expectation.expectedFulfillmentCount = 1

        service.fetchNextPage { result in
             switch result {
               case.failure(let error):
                   expectation.fulfill()
                   XCTAssertTrue(false, "Encounter an Unexpected error: \(error.localizedDescription)")
               case .success(let movies):
                   expectation.fulfill()
                   XCTAssertGreaterThan(movies.count, 0)
           }
        }

        wait(for: [expectation], timeout: 15.0)
    }

    func testServiceIvalidMovieId() {
        let expectation = XCTestExpectation(description: "Wait for service fetch movie response")
        expectation.expectedFulfillmentCount = 1

        service.fetchMovieDetail(movieId: -1 ) { result in
             switch result {
               case.failure(let error):
                   expectation.fulfill()
                   if case MovieServiceErrors.InvalidMovieId = error {
                        XCTAssertTrue(true, "Get expected error from service")
                   } else {
                        XCTAssertTrue(false, "Service returned incorrect error")
                   }
               case .success:
                   expectation.fulfill()
                   XCTAssertTrue(false, "Get movie with invalid Id")
           }
        }

        wait(for: [expectation], timeout: 15.0)
    }

}
