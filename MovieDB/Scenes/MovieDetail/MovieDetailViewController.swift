//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import ImageSlideshow
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
    @IBOutlet var imageSlideshowView: ImageSlideshow!
    

    var viewModel: MovieDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self
        viewModel?.fetchMovieDetail()

        view.setGradientBackground(topColor: #colorLiteral(red: 0.3262622058, green: 0.427818954, blue: 0.428390801, alpha: 1), bottomColor: #colorLiteral(red: 0.01249628421, green: 0.1611334383, blue: 0.1617439985, alpha: 1))

        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        pageIndicator.pageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageSlideshowView.pageIndicator = pageIndicator
        imageSlideshowView.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)

        imageSlideshowView.contentScaleMode = .scaleToFill

        imageSlideshowView.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        coverImageView.addRoundedBorder(radious: 12.0, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        rateContainerView.makeRoundedCorners(radious: 8.0)
    }

    func configureImageSlider() {
        guard let imagePaths = viewModel?.movieImages else { return }
        let sources = imagePaths.prefix(5).map {
            KingfisherSource(urlString: "\(Environment.MovieDBOriginalImageBasePath)\($0.filePath!)")!
        }
        imageSlideshowView.activityIndicator = DefaultActivityIndicator(style: .large, color: .white)
        imageSlideshowView.setImageInputs(sources)
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didFetchMovieImagePaths(error: MovieServiceErrors?) {
        if error == nil {
            DispatchQueue.main.async {
                self.configureImageSlider()
            }
        } else {
            if case MovieServiceErrors.InvalidCurrentPageNumber = error! {
                showErrorMessage(message: "The movie you selected is no longer available.")
            } else if case MovieServiceErrors.InvalidMovieId = error! {
                showErrorMessage(message: "The movie you selected is no longer available.")
            } else {
                showErrorMessage(message: "We encounter an API error, please check your internet connection and try again latter.")
                debugPrint("Error while getting images for movie: \(error!.localizedDescription)")
            }
        }
    }

    func didFetchMovieDetails(error: MovieServiceErrors?) {
        if error == nil {
            DispatchQueue.main.async {
                guard let viewModel = self.viewModel, let movieDetail = viewModel.movieInfo else { return }
                self.titleLabel.text = movieDetail.title
                self.coverImageView.downloadImage(from: movieDetail.posterPath)
                self.posterImageView.downloadImage(from: movieDetail.backdropPath)
                self.sinopsisTextView.text = movieDetail.overview
                self.rateLabel.text = movieDetail.voteAverage.description

                let movieMinutes = movieDetail.runtime
                self.durationLabel.text = "Duração \(movieMinutes/60)h \(movieMinutes%60)min"

                switch movieDetail.voteAverage {
                case _ where movieDetail.voteAverage < 5.0:
                    self.rateContainerView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                case _ where movieDetail.voteAverage >= 5.0 && movieDetail.voteAverage < 7.0:
                    self.rateContainerView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                case _ where movieDetail.voteAverage >= 7.0:
                    self.rateContainerView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                default:
                    self.rateContainerView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
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
