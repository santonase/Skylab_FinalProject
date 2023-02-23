//
//  GenresViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.02.2023.
//

import UIKit



class GenresViewController: UIViewController {
    
    @IBOutlet weak var GenresTableView: UITableView!
    var posterArray: [Media] = []

    var sectionTitle: [String] = ["Trending Movies", "Trending TV", "Popular Movies", "Popular TV", "Top rated"]
    
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
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell") as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
// case 1:
        case Sections.TrendingMovies.rawValue:
            let url = "https://api.themoviedb.org/3/movie/popular?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&page=1"
            NetworkManager().loadPosters(url: url) { response in
//                self.posterArray = response
                cell.posterArray = response
                cell.collectionView.reloadData()
        }
// case 2:
        case Sections.TrendingTV.rawValue:
            let url = "https://api.themoviedb.org/3/tv/popular?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&page=1"
            NetworkManager().loadPosters(url: url) { response in
//                self.posterArray = response
                cell.posterArray = response
                cell.collectionView.reloadData()
        }
// case 3:
        case Sections.PopularMovies.rawValue:
            let url = "https://api.themoviedb.org/3/movie/popular?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&page=1"
            NetworkManager().loadPosters(url: url) { response in
//                self.posterArray = response
                cell.posterArray = response
                cell.collectionView.reloadData()
        }
// case 4:
        case Sections.PopularTV.rawValue:
            let url = "https://api.themoviedb.org/3/tv/popular?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&page=1"
            NetworkManager().loadPosters(url: url) { response in
//                self.posterArray = response
                cell.posterArray = response
                cell.collectionView.reloadData()
        }
// case 5:
        case Sections.TopRated.rawValue:
            let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=513ec4b0669d007dc347e68ef5dff8fa&language=en-US&page=1"
            NetworkManager().loadPosters(url: url) { response in
//                self.posterArray = response
                cell.posterArray = response
                cell.collectionView.reloadData()
        }
        default:
            return UITableViewCell()
        }
     return cell
    }
}


