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
    
    var movie: Media?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWithMovie()
        backgroundUIImageView.applyBlurEffect()
        loadTrailer()
        
        playerView.layer.masksToBounds = true
        playerView.layer.cornerRadius = 10
    }
}
