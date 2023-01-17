//
//  ViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 11.01.2023.
//

import UIKit

//MARK: ViewController with trending Movies/Serials and search
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nib()
        requestTrendMovies()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            requestTrendMovies()
            print("segmentedIndex 0")
        } else {
            requestTrendTv()
            print("segmentedIndex 1")
        }
    }
    
    
    
}

