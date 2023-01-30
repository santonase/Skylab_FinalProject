//
//  extansion ViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.01.2023.
//

import UIKit

extension ViewController {
    
    
    //MARK: Nib register
     func nib() {
        let nib = UINib(nibName: Constants.Nib.cell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Nib.cell)
         print(Constants.Print.NibRegister)
    }
    
    //MARK: request trending movies
    func requestTrendMovies(page: Int) {
        
        let url = Constants.Network.baseURL + Constants.Network.trendingMovie + Constants.Network.keyAPI + "&page=\(page)"
        NetworkManager().loadMovies(url: url, page: page) { mediaArray in
            self.filteredData = mediaArray
            self.tableView.reloadData()
            print(Constants.Print.getTrendMovies)
    }
}
    
    //MARK: request trending tv
    func requestTrendTv() {
        
        let url = Constants.Network.baseURL + Constants.Network.trandingTv + Constants.Network.keyAPI
        NetworkManager().loadTv(url: url) { mediaArray in
            self.filteredData = mediaArray
            self.tableView.reloadData()
            print(Constants.Print.getTrendTv)
        }
    }
}

//MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.cell, for: indexPath) as? Cell {
            cell.configureWith(media: filteredData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = UIStoryboard(name: Constants.View.main, bundle: nil)
        if let deteilsController = main.instantiateViewController(withIdentifier: Constants.View.deteilsController) as? DeteilsController {
    
            if (segmentedControl.selectedSegmentIndex == 0) {
                deteilsController.movie = filteredData[indexPath.row]
                navigationController?.pushViewController(deteilsController, animated: true)
                
            } else if (segmentedControl.selectedSegmentIndex == 1) {
                deteilsController.movie = filteredData[indexPath.row]
                navigationController?.pushViewController(deteilsController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filteredData.count - 1, ViewController.currentPage < ViewController.totalPages {
            print("Next Page: \(ViewController.currentPage)")
            requestTrendMovies(page: ViewController.currentPage + 1)
            tableView.reloadData()
        }
    }
}


