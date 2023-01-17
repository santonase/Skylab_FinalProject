//
//  Constants.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

//MARK: Constants

struct Constants {
    
    struct Network {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let keyAPI = "513ec4b0669d007dc347e68ef5dff8fa"
        static let trendingMovie = "trending/movie/week?api_key="
        static let trandingTv = "trending/tv/week?api_key="
    }
    
    struct Nib {
        static let cell = "Cell"
    }
    
    static let poster = "https://image.tmdb.org/t/p/w1280"
}
