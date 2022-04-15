//
//  CacheManager.swift
//  RickMorty
//
//  Created by Nodirbek on 15.04.2022.
//

import Foundation
import UIKit

final class CacheManager {
    
    private let cache = NSCache<NSString, UIImage>()
    
    static let shared = CacheManager()
    
    private init() {}
    
    func getImage(for key: NSString) -> UIImage? {
        if let image = cache.object(forKey: key) {
            return image
        }
        return nil
    }
    
    func set(image: UIImage, key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
}
