//
//  CollectionViewCell.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 20.02.2023.
//

import UIKit
import Kingfisher


class PostersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image =  nil
    
    }
        
    public func configure(with model: String) {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
                return
            }
        posterImage.kf.setImage(with: url)
       }
    }

