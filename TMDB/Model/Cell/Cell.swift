//
//  Cell.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.01.2023.
//

import UIKit
import Kingfisher

class Cell: UITableViewCell {
    
    @IBOutlet weak var titleUILabel: UILabel!
    @IBOutlet weak var overviewUILabel: UILabel!
    @IBOutlet weak var posterUIImageView: UIImageView!
    
    @IBOutlet weak var ratingUILabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWith(media: Media) {
        titleUILabel.text = (media.originalTitle ?? "").count > 0 ? media.originalTitle : media.name
        overviewUILabel.text = media.overview ?? "no overview"
        ratingUILabel.text = "\(media.voteAverage ?? 0.0)"
        loadPoster(imageName: media.posterPath ?? "no poster")
    }
    
    private func loadPoster(imageName: String) {
        posterUIImageView.kf.setImage(with: URL(string: Constants.Poster.defaultPath + imageName))
        print("Load poster: \(String(describing: titleUILabel.text ?? ""))")
    }
}
