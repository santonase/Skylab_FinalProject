//
//  GenresModel.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 18.02.2023.
//

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
