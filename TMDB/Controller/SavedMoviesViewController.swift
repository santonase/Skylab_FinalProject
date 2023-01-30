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
    
    var savedMovies: [MovieRealm] = []
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nib = UINib(nibName: Constants.Nib.cell, bundle: nil)
        SavedMoviesTableView.register(nib, forCellReuseIdentifier: Constants.Nib.cell)
        
        savedMovies = DataManager.shared.getMovie()
        SavedMoviesTableView.reloadData()
    }
}

extension SavedMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SavedMoviesTableView.dequeueReusableCell(withIdentifier: Constants.Nib.cell, for: indexPath) as? Cell {
            cell.configureWith(movie: savedMovies[indexPath.row])
//            cell.textLabel?.text = savedMovies[indexPath.row].title
            return cell
        }
        return UITableViewCell()
    }
}

extension SavedMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try? Realm()
            
            try! realm?.write({
                realm?.delete(savedMovies[indexPath.row])
                savedMovies.remove(at: indexPath.row)
            })
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            tableView.reloadData()
        }
    }
}
