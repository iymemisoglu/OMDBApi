//
//  SecondViewController.swift
//  film
//
//  Created by İlker Yasin Memişoğlu on 21.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
   
    var imageUrl = String()
    var anImageView = UIImageView()
    var explanation = String()
    var actor = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchImage()
        explanationLabel.text = explanation
        actors.text = actor
    }
  
    func fetchImage() {
        
        let url = URL(string: imageUrl)
        anImageView.kf.setImage(with: url)
        movieImageView.image = anImageView.image

    }

}
