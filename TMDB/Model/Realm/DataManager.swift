//
//  DataManager.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 26.01.2023.
//
import RealmSwift

struct DataManager {
    static let shared = DataManager()
    private let realm = try? Realm()
    private init() {}
    func save(movie: Media?) {
        
        let movieRealm = MovieRealm()
        let isMovie = Bool()
        guard let movie = movie else { return }
        
        if let title = movie.title, (title).count > 0 {
            movieRealm.title = title
        } else if let title = movie.name {
            movieRealm.title = title
        }
        
        if let overview = movie.overview {
            movieRealm.overview = overview
        }
        
        if let rating = movie.voteAverage {
            movieRealm.rating = rating
        }
        
        if let posterPath = movie.posterPath {
            movieRealm.posterPath = posterPath
        }
        if let trailer = movie.id {
            movieRealm.trailer = trailer
        }
        
        if let mediaType = movie.mediaType {
            movieRealm.mediaType = mediaType
        }
        
        if isMovie == true {
            movieRealm.isMovie = true
        } else {
            movieRealm.isMovie = false
        }

        
        try? realm?.write {
            realm?.add(movieRealm)
        }
    }
    
    func getMovie() -> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let movieResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in movieResults {
            movies.append(movie)
        }
        return movies
    }
}
