//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var rateContainerView: UIView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var sinopsisTextView: UITextView!
    @IBOutlet var actorsScrollView: UIScrollView!
    @IBOutlet var actorsStackView: UIStackView!
    

    var viewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self
        viewModel?.fetchMovieDetail()
    }

}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didFetchMovieDetails(error: MovieServiceErrors?) {
        if error == nil {
            DispatchQueue.main.async {
                guard let viewModel = self.viewModel, let movieDetail = viewModel.movieInfo else { return }
                self.titleLabel.text = movieDetail.title
                self.coverImageView.downloadImage(from: movieDetail.posterPath)
                self.posterImageView.downloadImage(from: movieDetail.backdropPath)
                self.sinopsisTextView.text = movieDetail.overview
            }
        } else {
            if case MovieServiceErrors.InvalidCurrentPageNumber = error! {
                showErrorMessage(message: "The movie you selected is no longer available.")
            } else if case MovieServiceErrors.InvalidMovieId = error! {
                showErrorMessage(message: "The movie you selected is no longer available.")
            } else {
                showErrorMessage(message: "We encounter an API error, please check your internet connection and try again latter.")
                debugPrint("Error while getting data for movies: \(error!.localizedDescription)")
            }
        }
    }
}
