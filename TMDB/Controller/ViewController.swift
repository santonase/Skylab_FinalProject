//
//  ViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

import UIKit
//MARK: Show trending Movies/Serials and Search
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var filteredData: [Media] = []
    let queueGlobal = DispatchQueue.global()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nib()
        
        queueGlobal.async {
            self.requestTrendMovies()
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    //MARK: Switch between movies and tv
    @IBAction func didChangeSegment(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: requestTrendMovies()
                print(Constants.Print.segmentedIndexZero)
        case 1: requestTrendTv()
                print(Constants.Print.segmentedIndexOne)
        default: break
        }
    }
}

extension ViewController {
    
    //MARK: Nib register
     func nib() {
        let nib = UINib(nibName: Constants.Nib.cell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Nib.cell)
         print(Constants.Print.NibRegister)
    }
    
    //MARK: request trending movies
    func requestTrendMovies() {
        NetworkManager().loadMovies() { mediaArray in
            self.filteredData = mediaArray
            self.tableView.reloadData()
            print(Constants.Print.getTrendMovies)
    }
}
    
    //MARK: request trending tv
    func requestTrendTv() {
        NetworkManager().loadTv() { mediaArray in
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
                deteilsController.mediaType = "movie"
                navigationController?.pushViewController(deteilsController, animated: true)
                
            } else if (segmentedControl.selectedSegmentIndex == 1) {
                deteilsController.movie = filteredData[indexPath.row]
                deteilsController.mediaType = "tv"
                navigationController?.pushViewController(deteilsController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = filteredData.count - 1
        if indexPath.row == lastItem {
//            loadMorePages(page: currentPage)
            
        }
    }
}
//MARK: Hide keyboard
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
