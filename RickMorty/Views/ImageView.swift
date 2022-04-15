//
//  ImageView.swift
//  RickMorty
//
//  Created by Nodirbek on 14.04.2022.
//

import UIKit

final class ImageView: UIImageView {
    
    private let networkManager = NetworkManager()
    
    func downloadImage(from url: String) {
        
        networkManager.downloadImage(from: url) { [weak self] downloadedImage in
            DispatchQueue.main.async {
                self?.image = downloadedImage
            }
        }
    }
    
}

