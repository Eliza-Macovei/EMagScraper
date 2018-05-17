//
//  DetailsItem.swift
//  EmagScraper
//
//  Created by Elizabeta Macovei on 26/04/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit
import Foundation

class DetailsItem {
    var imageUrl: URL?
    let title: String
    let availability: String
    let shippingType: String
    let seller: String
    let descr: String
    let specs: String?
    
    var listOfThumbnailUrls: [URL?] = []
    
    weak var previewItem: PreviewItem? = nil
    
    init(_ imageUrl: String?, _ title: String, _ availability: String, _ shippingType: String, _ seller: String, _ descr: String, _ specs: String?) {
        self.imageUrl = imageUrl == nil ? nil : URL(string: imageUrl!)
        self.title = title
        self.availability = availability
        self.shippingType = shippingType
        self.seller = seller
        self.descr = descr
        self.specs = specs
    }
    
    func addThumbnailUrl(stringUrl: String?) {
        guard stringUrl != nil && !((stringUrl?.isEmpty)!) else {
            return
        }
        
        let url = URL(string: stringUrl!)
        if !listOfThumbnailUrls.contains(url) {
            listOfThumbnailUrls.append(url)
        }
    }
}
