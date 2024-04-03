//
//  ImageCache.swift
//  CineVerse
//
//  Created by chandru-13685 on 03/04/24.
//

import Foundation
import UIKit

// NSCache is thread safe so using Singleton class

class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, UIImage>
    private let cacheAccessQueue = DispatchQueue(label: "com.chandru.ImageCacheQueue")
    
    private init() {
        cache = NSCache<NSString, UIImage>()
        let maxCacheSize = 20 * 1024 * 1024
        cache.totalCostLimit = maxCacheSize
    }
    
    
    func getImage(for key: String) -> UIImage? {
        return cacheAccessQueue.sync {
            return cache.object(forKey: key as NSString)
        }
    }
    
    
    func setImage(_ image: UIImage, for key: String) {
        cacheAccessQueue.async {
            self.cache.setObject(image, forKey: key as NSString)
        }
    }
    
}
