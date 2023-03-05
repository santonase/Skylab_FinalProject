//
//  GenresViewController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 13.02.2023.
//

import UIKit



class GenresViewController: UIViewController {
    
    @IBOutlet weak var GenresTableView: UITableView!
    var viewModel = ViewModelGenresViewController()

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
        viewModel.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.collectionViewTableViewCell) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        viewModel.getPosters(for: indexPath.section, in: cell)
        return cell
    }
}


