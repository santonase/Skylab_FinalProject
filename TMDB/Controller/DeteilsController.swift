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
    @IBOutlet weak var overviewTextView: UITextView!
        
    @IBOutlet weak var saveAndDeleteButton: UIButton!
    
    
    var movie: Media?
    var movieFromRealm: MovieRealm?
    var mediaType = ""
    var isMediaInRealm: Bool?
    var mediaFromRealm: MovieRealm?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithMovie()
        backgroundUIImageView.applyBlurEffect()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10

        realmCheck(media: movie)
        
    }
    
    
    func realmCheck(media: Media?) {
        if media != nil {
            if DataManager.shared.isMovieInRealm(movie: media) {
                isMediaInRealm = true
                saveAndDeleteButton.setTitle(isMediaInRealm! ? "Delete" : "Save", for: .normal)
            } else {
                isMediaInRealm = false
                saveAndDeleteButton.setTitle(isMediaInRealm! ? "Delete" : "Save", for: .normal)
            }
            } else {
                isMediaInRealm = true
                saveAndDeleteButton.setTitle(isMediaInRealm! ? "Delete" : "Save", for: .normal)
            }
        }
    
    @IBAction func saveMovieToRealm(_ sender: Any) {
        saveAndDeleteButton.setTitle(isMediaInRealm! ? "Save" : "Delete", for: .normal)
        switch isMediaInRealm {
        case true:
            if let movie = movie {
                let movie = DataManager.shared.getFilm(movie: movie)
                DataManager.shared.deleteMedia(movie: movie)
                print("Delete media")
            } else if let mediaFromRealm = mediaFromRealm {
                DataManager.shared.deleteMedia(movie: mediaFromRealm)
                navigationController?.popToRootViewController(animated: true)
                print("Delete realm media")
            }
            isMediaInRealm = false
        case false:
            if mediaType == "movie" {
                DataManager.shared.save(movie: movie, isMovie: true)
            } else if mediaType == "tv" {
                DataManager.shared.save(movie: movie, isMovie: false)
            }
           print("Save media")
            isMediaInRealm = true
        default:
            break
        }
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
             overviewTextView.text = overview
         } else if let overviewRealm = movieFromRealm?.overview {
             overviewTextView.text = overviewRealm
         }
         
         if let trailerId = movie?.id {
             movieFromRealm?.trailer = trailerId
         }
         
         loadTrailer()
    }
    
    private func loadPoster(imageName: String) {
        backgroundUIImageView.kf.setImage(with: URL(string: Constants.Poster.defaultPath + imageName))
    }

    func loadTrailer() {
        if mediaType == "movie" {
            NetworkManager().getMovieTrailer(movieId: movie?.id ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == "Trailer") {
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
        } else if movieFromRealm?.isMovie == true {
            NetworkManager().getMovieTrailer(movieId: movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if trailer.type == "Trailer" {
                        self.playerView.load(withVideoId: trailer.key)
                        }
                    }
                }
        } else if movieFromRealm?.isMovie == false {
            NetworkManager().getTvTrailer(movieId: movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == "Trailer") || (trailer.type == "Teaser") {
                        self.playerView.load(withVideoId: trailer.key)
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
