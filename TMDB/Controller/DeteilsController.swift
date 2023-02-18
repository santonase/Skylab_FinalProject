//
//  DeteilsController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 23.01.2023.
//

import UIKit
import youtube_ios_player_helper

class DeteilsController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundUIImageView: UIImageView!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ReleaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    var movie: Media?
    var movieFromRealm: MovieRealm?
    var mediaType = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithMovie()
        backgroundUIImageView.applyBlurEffect()
        self.loadTrailer()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
    }
    
    @IBAction func saveMovieToRealm(_ sender: Any) {
        DataManager.shared.save(movie: movie)
        print("Save movie")
    }
}

extension DeteilsController {
    
     func configureWithMovie() {
         if let movieTitle = (movie?.title ?? "").count > 0 ? movie?.title : movie?.name {
             titleLabel.text = movieTitle
         } else if let movieRealmTitle = movieFromRealm?.title {
             titleLabel.text = movieRealmTitle
         }
        print("Did select: \(String(describing: titleLabel.text ?? ""))")
                  
         loadPoster(imageName: ((movie?.posterPath ?? "").count > 0 ? movie?.posterPath : movieFromRealm?.posterPath) ?? "")

         
         if let releaseDate = movie?.releaseDate?.count ?? 0 > 0 ? movie?.releaseDate : movie?.firstAirDate {
             ReleaseLabel.text = releaseDate
             ReleaseLabel.text = "Release date: \(releaseDate)"
         }
         
         if let rating = movie?.voteAverage {
             ratingLabel.text = "Rating: \(rating)"
         } else if let ratingRealm = movieFromRealm?.rating {
             ratingLabel.text = "Rating: \(ratingRealm)"
         }
         
         if let overview = movie?.overview {
             descriptionLabel.text = overview
         } else if let overviewRealm = movieFromRealm?.overview {
             descriptionLabel.text = overviewRealm
         }
         
         if let trailerId = movie?.id {
             movieFromRealm?.trailer = trailerId
         }
    }
    
    private func loadPoster(imageName: String) {
        backgroundUIImageView.kf.setImage(with: URL(string: Constants.Poster.defaultPath + imageName))
    }

    func loadTrailer() {
        if mediaType == "movie" {
            NetworkManager().getMovieTrailer(movieId: movie?.id ?? 0) { id in
                id.forEach { trailer in
                    if trailer.type == "Trailer" {
                        self.playerView.load(withVideoId: trailer.key)
                    }
                }
            }
        } else if mediaType == "tv" {
            NetworkManager().getTvTrailer(movieId: movie?.id ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == "Trailer") || (trailer.type == "Teaser") {
                        self.playerView.load(withVideoId: trailer.key)
                    }
                }
            }
        } else if movieFromRealm?.mediaType == "movie" {
            NetworkManager().getMovieTrailer(movieId: movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if trailer.type == "Trailer" {
                        self.playerView.load(withVideoId: trailer.key)
                        }
                    }
                }
        } else if movieFromRealm?.mediaType == "tv" {
            NetworkManager().getTvTrailer(movieId: movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == "Trailer") ||  (trailer.type == "Teaser") {
                        self.playerView.load(withVideoId: trailer.key)
                    }
                }
            }
        } else if (ViewController().searchBar != nil) {
            if mediaType == "movie" {
                NetworkManager().getMovieTrailer(movieId: movie?.id ?? 0) { id in
                    id.forEach { trailer in
                        if trailer.type == "Trailer" {
                            self.playerView.load(withVideoId: trailer.key)
                        }
                    }
                }
            } else if mediaType == "tv" {
                NetworkManager().getTvTrailer(movieId: movie?.id ?? 0) { id in
                    id.forEach { trailer in
                        if (trailer.type == "Trailer") || (trailer.type == "Teaser") {
                            self.playerView.load(withVideoId: trailer.key)
                        }
                    }
                }
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
