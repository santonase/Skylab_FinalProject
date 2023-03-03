//
//  TrendingViewModel.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 01.03.2023.
//

final class ViewModelTrendingViewController {
    var filteredData: [Media] = []
    var movie: Media?
    
    func requestTrendMovies(complition: @escaping() -> Void) {
        NetworkManager().loadMovies() { mediaArray in
            self.filteredData = mediaArray
            complition()
        }
    }
    
    func requestTrendTv(complition: @escaping() -> Void) {
        NetworkManager().loadTv() { mediaArray in
            self.filteredData = mediaArray
            complition()
        }
    }
}
