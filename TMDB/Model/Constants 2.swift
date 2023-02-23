//
//  Constants.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

// MARK: Constants

struct Constants {
    
    struct Page {
        static var current = 0
        static var total = 0
    }
    
    struct Network {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let keyAPI = "513ec4b0669d007dc347e68ef5dff8fa"
        static let trendingMovie = "trending/movie/week?api_key="
        static let trandingTv = "trending/tv/week?api_key="
    }
    
    struct Search {
        static let searchText = ""
    }
    struct Nib {
        static let cell = "Cell"
    }
    struct Poster {
        static let defaultPath = "https://image.tmdb.org/t/p/w1280"
    }
    struct Print {
        static let NibRegister = "Nib register"
        static let segmentedIndexZero = "SegmentedIndex = 0"
        static let segmentedIndexOne = "SegmentedIndex = 1"
        static let getTrendMovies = "Get trending movies"
        static let getTrendTv = "Get trending tv"
    }
    
    struct View {
        static let main = "Main"
        static let deteilsController = "DeteilsController"
    }
}
