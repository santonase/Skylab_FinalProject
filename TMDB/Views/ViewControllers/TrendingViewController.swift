//
//  ViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

import UIKit
//MARK: Show trending Movies/Serials and Search
class TrendingViewController: UIViewController {
    
// MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: Constants.trendingTableViewCell, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: Constants.trendingTableViewCell)
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - let/var
    var viewModel = ViewModelTrendingViewController()
    
    // MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTrendingMovies()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - IBActions
    
    //Switch between movies and tv
    @IBAction func didChangeSegment(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: loadTrendingMovies()
        case 1: loadTrendingTv()
        default: break
        }
    }
}

// MARK: - extensions
extension TrendingViewController {
    
    //request trending movies
    func loadTrendingMovies() {
        viewModel.requestTrendMovies() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    //equest trending tv
    func loadTrendingTv() {
        viewModel.requestTrendTv() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension TrendingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.trendingTableViewCell, for: indexPath) as? TrendingTableViewCell {
            cell.configureWith(media: viewModel.filteredData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = UIStoryboard(name: Constants.main, bundle: nil)
        if let detailsController = main.instantiateViewController(withIdentifier: Constants.detailsController) as? DetailsViewController {
    
            if (segmentedControl.selectedSegmentIndex == 0) {
                detailsController.viewModel.movie = viewModel.filteredData[indexPath.row]
                detailsController.viewModel.mediaType = Constants.movie
                navigationController?.pushViewController(detailsController, animated: true)
                
            } else if (segmentedControl.selectedSegmentIndex == 1) {
                detailsController.viewModel.movie = viewModel.filteredData[indexPath.row]
                detailsController.viewModel.mediaType = Constants.tv
                navigationController?.pushViewController(detailsController, animated: true)
            }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
