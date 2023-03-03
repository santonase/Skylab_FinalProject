//
//  GenresViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.02.2023.
//

import UIKit



class GenresViewController: UIViewController {
    
    @IBOutlet weak var GenresTableView: UITableView!
    var viewModel = ViewModelGenresViewController()
    enum Sections: Int {
        case TrendingMovies = 0
        case TrendingTV = 1
        case PopularMovies = 2
        case PopularTV = 3
        case TopRated = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension GenresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.collectionViewTableViewCell) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
// case 1:
        case Sections.TrendingMovies.rawValue:
            let url = Constants.baseURL + Constants.trendingMovie + Constants.keyAPI
            NetworkManager().loadPosters(url: url) { response in
                cell.viewModel.posterArray = response
                cell.collectionView.reloadData()
        }
// case 2:
        case Sections.TrendingTV.rawValue:
            let url = Constants.baseURL + Constants.trandingTv + Constants.keyAPI
            NetworkManager().loadPosters(url: url) { response in
                cell.viewModel.posterArray = response
                cell.collectionView.reloadData()
        }
// case 3:
        case Sections.PopularMovies.rawValue:
            let url = Constants.baseURL + Constants.popularMovies + Constants.keyAPI
            NetworkManager().loadPosters(url: url) { response in
                cell.viewModel.posterArray = response
                cell.collectionView.reloadData()
        }
// case 4:
        case Sections.PopularTV.rawValue:
            let url = Constants.baseURL + Constants.popularTv + Constants.keyAPI

            NetworkManager().loadPosters(url: url) { response in
                cell.viewModel.posterArray = response
                cell.collectionView.reloadData()
        }
// case 5:
        case Sections.TopRated.rawValue:
            let url = Constants.baseURL + Constants.topRated + Constants.keyAPI
            NetworkManager().loadPosters(url: url) { response in
                cell.viewModel.posterArray = response
                cell.collectionView.reloadData()
        }
        default:
            return UITableViewCell()
        }
     return cell
    }
}


