//
//  SearchBar.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 16.01.2023.
//

import UIKit
//MARK: Search movies
extension TrendingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count != 0 else { return }
        var type: MediaType = .movie
        if segmentedControl.selectedSegmentIndex == 0 {
            type = .movie
        } else {
            type = .tv
        }
        //search movies and series
        NetworkManager().searchMedia(mediaType: type, search: searchText) { search in
            self.viewModel.filteredData = search
            self.tableView.reloadData()
        }
    }
    //press button Search for hide keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
