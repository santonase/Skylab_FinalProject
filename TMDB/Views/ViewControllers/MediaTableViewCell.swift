//
//  CollectionViewTableViewCell.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 20.02.2023.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var viewModel = ViewModelMediaTableViewCell()
}

extension MediaTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.posterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as? PostersCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let modelPoster = viewModel.posterArray[indexPath.row].posterPath else {
            return UICollectionViewCell()
        }
        cell.configure(with: modelPoster)
        return cell
    }
}
