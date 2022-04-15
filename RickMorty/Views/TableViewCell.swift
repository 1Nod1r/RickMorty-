//
//  TableViewCell.swift
//  RickMorty
//
//  Created by Nodirbek on 14.04.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var raceLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: ImageView!
    
    func configure(with data: ResultDataModel) {
        raceLabel.text = data.species
        genderLabel.text = data.gender
        nameLabel.text = data.name
        avatarImageView.downloadImage(from: data.image)
    }

}
