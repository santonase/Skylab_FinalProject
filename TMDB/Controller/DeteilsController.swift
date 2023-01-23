//
//  DeteilsController.swift
//  TMDB
//
//  Created by Sviatoslav Binovskyi on 23.01.2023.
//

import UIKit

class DeteilsController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundUIImageView: UIImageView!
        
    
    
    var movie: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWithMovie()
        backgroundUIImageView.applyBlurEffect()
    }
}
