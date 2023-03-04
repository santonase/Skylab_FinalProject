//
//  Constants.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

// MARK: Constants

struct Constants {
    
    enum mediaType: String {
        case movie
        case tv
    }

    static let save = "save"
    static let delete = "delete"
    static let movie = "movie"
    static let tv = "tv"
    static let noPoster = "No poster"
    static let noOverview = "No overview"
    static let releaseDate = "Release date:"
    static let rating = "Rating:"
    static let trailer = "Trailer"
    static let teaser = "Teaser"
    static let nothing = "nothing"
    
    
    static let posterPath = "https://image.tmdb.org/t/p/w500"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let keyAPI = "513ec4b0669d007dc347e68ef5dff8fa"
    static let trendingMovie = "trending/movie/week?api_key="
    static let trandingTv = "trending/tv/week?api_key="
    static let trendingMoviesURL = "https://api.themoviedb.org/3/trending/week?api_key=513ec4b0669d007dc347e68ef5dff8fa"
    static let popularMovies = "movie/popular?api_key="
    static let popularTv = "tv/popular?api_key="
    static let topRated = "movie/top_rated?api_key="
    
    static let searchText = ""
    static let trendingTableViewCell = "TrendingTableViewCell"
    static let collectionViewCell = "CollectionViewCell"
    
    static let defaultPath = "https://image.tmdb.org/t/p/w1280"
    
    static let main = "Main"
    static let detailsController = "DetailsController"
    static let collectionViewTableViewCell = "CollectionViewTableViewCell"

}
