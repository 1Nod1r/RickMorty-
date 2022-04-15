//
//  SecondViewController.swift
//  RickMorty
//
//  Created by Nodirbek on 14/04/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var ImageView: ImageView!
    @IBOutlet weak var NumberOfEpisodes: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var RaceLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    
    let cache = NSCache<NSString, UIImage>()
    
    var viewModel: SecondViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let model = viewModel.getModel()
        let cacheKey = NSString(string: model.image)
        
        if let image = CacheManager.shared.getImage(for: cacheKey) {
            ImageView.image = image
        }
        NumberOfEpisodes.text = "Количество эпизодов \(model.episode.count)"
        LocationLabel.text = model.location.name
        StatusLabel.text = model.status
        GenderLabel.text = model.gender
        RaceLabel.text = model.species
        NameLabel.text = model.name
    }
    

}




