//
//  SearchBar.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 16.01.2023.
//

import UIKit
//MARK: Search movies
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count != 0 else { return }
        var type: MediaType = .movie
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Searching Movies")
            type = .movie
        } else {
            print("Searching TV")
            type = .tv
        }
        NetworkManager().searchMedia(mediaType: type, search: searchText) { search in
            self.filteredData = search
            self.tableView.reloadData()
        }
    }
}
