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
        
        guard let movie = movie else { return }

        if let title = movie.title, (title).count > 0 {
            movieRealm.title = title
        }
        
        if let title = movie.name {
            movieRealm.title = title
        }

        movieRealm.overview = movie.overview ?? ""
        movieRealm.rating = movie.voteAverage ?? 0
        movieRealm.posterPath = movie.posterPath ?? ""
        
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
