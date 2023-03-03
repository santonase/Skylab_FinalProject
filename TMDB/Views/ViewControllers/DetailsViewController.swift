//
//  DeteilsController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 23.01.2023.
//

import UIKit
import youtube_ios_player_helper

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundUIImageView: UIImageView!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ReleaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var saveAndDeleteButton: UIButton!
    
    var viewModel = ViewModelDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithMovie()
        backgroundUIImageView.applyBlurEffect()
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10

        realmCheck(media: viewModel.movie)
 
    }
    
    func realmCheck(media: Media?) {
        if media != nil {
            if DataManager.shared.isMovieInRealm(movie: media) {
                viewModel.isMediaInRealm = true
                saveAndDeleteButton.setTitle(viewModel.isMediaInRealm! ? Constants.delete : Constants.save, for: .normal)
            } else {
                viewModel.isMediaInRealm = false
                saveAndDeleteButton.setTitle(viewModel.isMediaInRealm! ? Constants.delete : Constants.save, for: .normal)
            }
            } else {
                viewModel.isMediaInRealm = true
                saveAndDeleteButton.setTitle(viewModel.isMediaInRealm! ? Constants.delete : Constants.save, for: .normal)
            }
        }
    
    @IBAction func saveMovieToRealm(_ sender: Any) {
        saveAndDeleteButton.setTitle(viewModel.isMediaInRealm! ? Constants.save : Constants.delete, for: .normal)
        switch viewModel.isMediaInRealm {
        case true:
            if let movie = viewModel.movie {
                let movie = DataManager.shared.getFilm(movie: movie)
                DataManager.shared.deleteMedia(movie: movie)
            } else if let movieFromRealm = viewModel.movieFromRealm {
                DataManager.shared.deleteMedia(movie: movieFromRealm)
                navigationController?.popToRootViewController(animated: true)
            }
            viewModel.isMediaInRealm = false
        case false:
            if viewModel.mediaType == Constants.movie {
                DataManager.shared.save(movie: viewModel.movie, isMovie: true)
            } else if viewModel.mediaType == Constants.tv {
                DataManager.shared.save(movie: viewModel.movie, isMovie: false)
            }
            viewModel.isMediaInRealm = true
        default:
            break
        }
    }
    
}

extension DetailsViewController {
    
     func configureWithMovie() {
         if let movieTitle = (viewModel.movie?.title ?? "").count > 0 ? viewModel.movie?.title : viewModel.movie?.name {
             titleLabel.text = movieTitle
         } else if let movieRealmTitle = viewModel.movieFromRealm?.title {
             titleLabel.text = movieRealmTitle
         }
                  
         loadPoster(imageName: ((viewModel.movie?.posterPath ?? "").count > 0 ? viewModel.movie?.posterPath : viewModel.movieFromRealm?.posterPath) ?? "")

         if let releaseDate = viewModel.movie?.releaseDate?.count ?? 0 > 0 ? viewModel.movie?.releaseDate : viewModel.movie?.firstAirDate {
             ReleaseLabel.text = releaseDate
             ReleaseLabel.text = "\(Constants.releaseDate) \(releaseDate)"
         }
         
         if let rating = viewModel.movie?.voteAverage {
             ratingLabel.text = "\(Constants.rating) \(rating)"
         } else if let ratingRealm = viewModel.movieFromRealm?.rating {
             ratingLabel.text = "\(Constants.rating) \(ratingRealm)"
         }
         
         if let overview = viewModel.movie?.overview {
             overviewTextView.text = overview
         } else if let overviewRealm = viewModel.movieFromRealm?.overview {
             overviewTextView.text = overviewRealm
         }
         
         if let trailerId = viewModel.movie?.id {
             viewModel.movieFromRealm?.trailer = trailerId
         }
         
         loadTrailer()
    }
    
    private func loadPoster(imageName: String) {
        backgroundUIImageView.kf.setImage(with: URL(string: Constants.defaultPath + imageName))
    }

    func loadTrailer() {
        if viewModel.mediaType == Constants.movie {
            NetworkManager().getMovieTrailer(movieId: viewModel.movie?.id ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == Constants.trailer) {
                        self.playerView.load(withVideoId: trailer.key)
                    }
                }
            }
        } else if viewModel.mediaType == Constants.tv {
            NetworkManager().getTvTrailer(movieId: viewModel.movie?.id ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == Constants.trailer) || (trailer.type == Constants.teaser) {
                        self.playerView.load(withVideoId: trailer.key)
                    }
                }
            }
        } else if viewModel.movieFromRealm?.isMovie == true {
            NetworkManager().getMovieTrailer(movieId: viewModel.movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if trailer.type == Constants.trailer {
                        self.playerView.load(withVideoId: trailer.key)
                        }
                    }
                }
        } else if viewModel.movieFromRealm?.isMovie == false {
            NetworkManager().getTvTrailer(movieId: viewModel.movieFromRealm?.trailer ?? 0) { id in
                id.forEach { trailer in
                    if (trailer.type == Constants.trailer) || (trailer.type == Constants.teaser) {
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
