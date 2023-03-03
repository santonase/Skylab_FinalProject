//
//  CollectionViewTableViewCell.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 20.02.2023.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var posterArray: [Media] = []

    func configure(with poster: [Media]) {
        self.posterArray = poster
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let modelPoster = posterArray[indexPath.row].posterPath else {
            return UICollectionViewCell()
        }
        cell.configure(with: modelPoster)
        return cell
    }
}
