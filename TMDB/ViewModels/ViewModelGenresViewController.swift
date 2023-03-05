//
//  ViewModelGenresViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 03.03.2023.
//

import UIKit

final class ViewModelGenresViewController {
    
    var sectionTitle: [String] = ["Trending Movies", "Trending TV", "Popular Movies", "Popular TV", "Top rated"]
    
    enum Sections: Int {
        case TrendingMovies = 0
        case TrendingTV = 1
        case PopularMovies = 2
        case PopularTV = 3
        case TopRated = 4
    }
    
    func getPosters(for section: Int, in cell: MediaTableViewCell) {
        switch section {
        case Sections.TrendingMovies.rawValue:
                   let url = Constants.baseURL + Constants.trendingMovie + Constants.keyAPI
                   NetworkManager().loadPosters(url: url) { response in
                       cell.viewModel.posterArray = response
                       cell.collectionView.reloadData()
               }
               case Sections.TrendingTV.rawValue:
                   let url = Constants.baseURL + Constants.trandingTv + Constants.keyAPI
                   NetworkManager().loadPosters(url: url) { response in
                       cell.viewModel.posterArray = response
                       cell.collectionView.reloadData()
               }
               case Sections.PopularMovies.rawValue:
                   let url = Constants.baseURL + Constants.popularMovies + Constants.keyAPI
                   NetworkManager().loadPosters(url: url) { response in
                       cell.viewModel.posterArray = response
                       cell.collectionView.reloadData()
               }
               case Sections.PopularTV.rawValue:
                   let url = Constants.baseURL + Constants.popularTv + Constants.keyAPI
       
                   NetworkManager().loadPosters(url: url) { response in
                       cell.viewModel.posterArray = response
                       cell.collectionView.reloadData()
               }
               case Sections.TopRated.rawValue:
                   let url = Constants.baseURL + Constants.topRated + Constants.keyAPI
                   NetworkManager().loadPosters(url: url) { response in
                       cell.viewModel.posterArray = response
                       cell.collectionView.reloadData()
               }
        default:
            print(Constants.nothing)
        }
    }
}
