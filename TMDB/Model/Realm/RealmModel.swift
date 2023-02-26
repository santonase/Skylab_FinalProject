//
//  RealmModel.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 26.01.2023.
//
import RealmSwift

class MovieRealm: Object {
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var title = ""
    @Persisted var overview = ""
    @Persisted var rating = 0.0
    @Persisted var posterPath = ""
    @Persisted var trailer = 0
    @Persisted var mediaType = ""
    @Persisted var isMovie: Bool
}
