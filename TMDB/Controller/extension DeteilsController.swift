//
//  extension DeteilsController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 23.01.2023.
//

import Foundation
import UIKit

extension DeteilsController {
    
     func configureWithMovie() {
        titleLabel.text = (movie?.title ?? "").count > 0 ? movie?.title : movie?.name
        print("Did select: \(String(describing: titleLabel.text ?? ""))")
         
         loadPoster(imageName: movie?.posterPath ?? "no poster")
         
         if let releaseDate = movie?.releaseDate?.count ?? 0 > 0 ? movie?.releaseDate : movie?.firstAirDate {
             ReleaseLabel.text = "Release date: \(releaseDate)"
             ratingLabel.text = "Rating: \(String(describing: movie?.voteAverage ?? 0))"
             descriptionLabel.text = movie?.overview ?? "no overview"
         }
    }
    
    private func loadPoster(imageName: String) {
        backgroundUIImageView.kf.setImage(with: URL(string: Constants.Poster.defaultPath + imageName))
    }
    
    func loadTrailer() {
        if movie?.mediaType == "movie" {
            NetworkManager().getMovieTrailer(movieId: movie?.id ?? 0) { trailer in
                self.playerView.load(withVideoId: trailer.first?.key ?? "")
                print("Load trailer \(String(describing: self.movie?.id ?? 0))")
                print("Key: " + (trailer.last?.key ?? "Nil"))
            }
        } else {
            NetworkManager().getTvTrailer(movieId: movie?.id ?? 0) { trailer in
                self.playerView.load(withVideoId: trailer.first?.key ?? "")
                print("Load trailer \(String(describing: self.movie?.id ?? 0))")
                print("Key: " + (trailer.last?.key ?? "Nil"))
            }
        }
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
