//
//  MainListViewController.swift
//  MovieDB
//
//  Created by Hariel Giacomuzzi on 16/12/19.
//  Copyright © 2019 Hariel Giacomuzzi. All rights reserved.
//

import Foundation
import UIKit

class MainListViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var viewModel: MainListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = MainListViewModel()
        viewModel.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.fetchMovies()
    }

    func showErrorMessage(message: String) {
        let message = UIAlertController(title: "Oops, something has gone wrong", message: message, preferredStyle: .alert)
        present(message, animated: true, completion: nil)
    }

}

extension MainListViewController: MainListViewModelDelegate {
    func didFetchMovies(error: MovieServiceErrors?) {
        if error == nil {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            if case MovieServiceErrors.InvalidCurrentPageNumber = error! {
                debugPrint("No more items to display")
            } else if case MovieServiceErrors.InvalidMovieId = error! {
                showErrorMessage(message: "The movie you selected is no longer available.")
            } else {
                showErrorMessage(message: "We encounter an API error, please check your internet connection and try again latter.")
                debugPrint("Error while getting data for movies: \(error!.localizedDescription)")
            }
        }
    }
}

extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MainListCell)
        guard let movieCell = cell as? MovieTableViewCell else { return UITableViewCell() }
        let cellModel = MovieCellViewModel(with: viewModel.movies[indexPath.row])
        movieCell.configure(with: cellModel)
        return movieCell
    }
}

extension MainListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }

}
