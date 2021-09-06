//
//  DetailViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 06.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(with: movie!)
    }
    
    func setup(with movie: Movie) {
        
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate.convertToDateFormat().convertToStringFormat()
        taglineLabel.text = movie.overview
        let imagePath = "https://image.tmdb.org/t/p/w1280" + movie.backdropPath!
        guard let url = URL(string: imagePath) else { return }
        posterView.loadImage(at: url, cropped: false)
    }
    
    
}
