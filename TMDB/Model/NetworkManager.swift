//
//  NetworkManager.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

import Alamofire

//MARK: NetworkManager
struct NetworkManager {
    
    enum mediaType: String {
        case movie
        case tv
    }
    
//MARK: request trending movies
    func loadMovies(url: String, completion: @escaping([Media])->()) {
        AF.request(url).responseDecodable(of: MediaModel.self) { response in
            let mediaData = response
            completion(mediaData.value?.results ?? [])
        }
    }
    
    //MARK: request trending tv
    func loadTv(url: String, completion: @escaping([Media])->()) {
        AF.request(url).responseDecodable(of: MediaModel.self) { response in
            let mediaData = response
            completion(mediaData.value?.results ?? [])
        }
    }
}
