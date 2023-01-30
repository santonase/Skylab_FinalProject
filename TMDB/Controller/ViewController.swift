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
    static var currentPage = 1
    static var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nib()
        requestTrendMovies(page: ViewController.currentPage)
        
    }
    //MARK: Switch between movies and tv
    @IBAction func didChangeSegment(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: requestTrendMovies(page: ViewController.currentPage)
                print(Constants.Print.segmentedIndexZero)
        case 1: requestTrendTv()
                print(Constants.Print.segmentedIndexOne)
        default: break
        }
    }
}

