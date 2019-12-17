//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var scoreView: UIView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var movieDescriptionTextView: UITextView!
    @IBOutlet var yearLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        movieImage.image = nil
        movieTitle.text = ""
        movieDescriptionTextView.text = ""
        yearLabel.text = ""
        scoreLabel.text = ""
        scoreView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }

    func configure(with viewModel: MovieCellViewModel) {
        movieImage.downloadImage(from: viewModel.moviePosterPath)
        movieTitle.text = viewModel.movieTitle
        movieDescriptionTextView.text = viewModel.movieDescription
        scoreLabel.text = viewModel.movieRating
        yearLabel.text = viewModel.movieYear

        switch viewModel.movieRatingValue {
        case _ where viewModel.movieRatingValue < 5.0:
            scoreView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case _ where viewModel.movieRatingValue >= 5.0 && viewModel.movieRatingValue < 7.0:
        scoreView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case _ where viewModel.movieRatingValue >= 7.0:
        scoreView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        default:
            scoreView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
    }

    private func setupViews() {
        movieImage.addRoundedBorder(radious: 12.0, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        scoreView.makeRoundedCorners(radious: 8.0)
        containerView.makeRoundedCorners(radious: 20.0)
    }
    
}
