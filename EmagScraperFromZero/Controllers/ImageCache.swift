//
//  ImageCache.swift
//  EmagScraperFromZero
//
//  Created by Pinzariu Marian on 14/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation

class ImageCache {
    
    static let sharedCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "ImageCache"
        cache.countLimit = 10 // Max 20 images in memory.
        cache.totalCostLimit = 5 * 1024 * 1024 // Max 10MB used.
        return cache
    }()
}
