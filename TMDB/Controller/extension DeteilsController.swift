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
    }
    
    
    private func loadPoster(imageName: String) {
        backgroundUIImageView.kf.setImage(with: URL(string: Constants.Poster.defaultPath + imageName))
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
