//
//  extansion ViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.01.2023.
//

import UIKit

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
}

extension ViewController {
    
    //MARK: Nib register
     func nib() {
        let nib = UINib(nibName: Constants.Nib.cell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Nib.cell)
        print("Register Nib")
    }
    
    //MARK: request trending movies
     func requestTrendMovies() {
        
        let url = Constants.Network.baseURL + Constants.Network.trendingMovie + Constants.Network.keyAPI
        
        NetworkManager().loadMovies(url: url) { mediaArray in
            self.filteredData = mediaArray
            self.tableView.reloadData()
            print("Get trending movies")
        }
    }
    
    func requestTrendTv() {
        
        let url = Constants.Network.baseURL + Constants.Network.trandingTv + Constants.Network.keyAPI
        
        NetworkManager().loadMovies(url: url) { mediaArray in
            self.filteredData = mediaArray
            self.tableView.reloadData()
            print("Get trending tv")
        }
    }
    
    
}
