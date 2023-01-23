//
//  DeteilsController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 23.01.2023.
//

import UIKit

class DeteilsController: UIViewController {
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    var movie: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.text = movie?.title
    }
    
}
