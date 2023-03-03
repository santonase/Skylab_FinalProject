//
//  SavedMoviesViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 30.01.2023.
//

import UIKit
import RealmSwift

class SavedMoviesViewController: UIViewController {
    
    @IBOutlet weak var SavedMoviesTableView: UITableView!
    
    var viewModel = ViewModelSavedMoviesViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nib = UINib(nibName: Constants.trendingTableViewCell, bundle: nil)
        SavedMoviesTableView.register(nib, forCellReuseIdentifier: Constants.trendingTableViewCell)
        
        viewModel.savedMovies = DataManager.shared.getMovie()
        SavedMoviesTableView.reloadData()
    }
}

extension SavedMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SavedMoviesTableView.dequeueReusableCell(withIdentifier: Constants.trendingTableViewCell, for: indexPath) as? TrendingTableViewCell {
            cell.configureWith(movie: viewModel.savedMovies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension SavedMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: Constants.main, bundle: nil)
        if let deteilsController = main.instantiateViewController(withIdentifier: Constants.detailsController) as? DetailsViewController {
            deteilsController.viewModel.movieFromRealm = viewModel.savedMovies[indexPath.row]
            navigationController?.pushViewController(deteilsController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try? Realm()
            
            try! realm?.write({
                realm?.delete(viewModel.savedMovies[indexPath.row])
                viewModel.savedMovies.remove(at: indexPath.row)
            })
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            tableView.reloadData()
        }
    }
}
