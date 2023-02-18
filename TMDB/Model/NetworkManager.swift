//
//  NetworkManager.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

import Alamofire

enum MediaType: String {
    case movie
    case tv
}

// MARK: NetworkManager
struct NetworkManager {
    // MARK: request trending movies
    func loadMovies(url: String, completion: @escaping([Media]) -> Void) {
        AF.request(url).responseDecodable(of: MediaModel.self) { response in
            let mediaData = response
            completion(mediaData.value?.results ?? [])
        }
    }
    // MARK: request trending tv
    func loadTv(url: String, completion: @escaping([Media]) -> Void) {
        AF.request(url).responseDecodable(of: MediaModel.self) { response in
            let mediaData = response
            completion(mediaData.value?.results ?? [])
        }
    }
    // MARK: request search
    func searchMedia(mediaType: MediaType, search: String, competion: @escaping([Media]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/search/\(mediaType)?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&query=\(search.replacingOccurrences(of: " ", with: "%20"))&page=1&include_adult=false"
        
        AF.request(url).responseDecodable(of: MediaModel.self) { response in
            let mediaData = response
            competion(mediaData.value?.results ?? [])
        }
    }
    
        //MARK: - get trailers
    
    
    
    func getMovieTrailer(movieId: Int, completion: @escaping([TrailerResult]) -> Void) {
                
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US"
        AF.request(url).responseDecodable(of: TrailerModel.self) { response in
            let mediaData = response.value?.results ?? []
            completion(mediaData)
        }
    }
    
    func getTvTrailer(movieId: Int, completion: @escaping([TrailerResult]) -> Void) {
                
        let url = "https://api.themoviedb.org/3/tv/\(movieId)/videos?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US"
        AF.request(url).responseDecodable(of: TrailerModel.self) { response in
            let mediaData = response.value?.results ?? []
            completion(mediaData)
        }
    }
}
