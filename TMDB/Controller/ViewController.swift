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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nib()
        requestTrendMovies()
        
    }
    //MARK: Switch between movies and tv
    @IBAction func didChangeSegment(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            requestTrendMovies()
            print(Constants.Print.segmentedIndexZero)
        } else {
            requestTrendTv()
            print(Constants.Print.segmentedIndexOne)
        }
    }
}

