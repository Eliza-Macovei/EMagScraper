//
//  Item.swift
//  EmagScraper
//
//  Created by Elizabeta Macovei on 25/04/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import UIKit

class PreviewItem {
    let origin: String // = "eMag"
    let title: String
    let thumbnailUrl: URL?
    let price: Double
    let priceCoin: String
    let detailsUrl: URL?
    
    var detailsItem: DetailsItem? = nil
    
    init(_ origin: String, _ title: String, _ thumbnailUrl: String?, _ price: Double, _ coin: String, _ detailsUrl: String?) {
        self.origin = origin
        self.title = title
        self.price = price
        self.priceCoin = coin
        self.thumbnailUrl = thumbnailUrl == nil ? nil : URL(string: thumbnailUrl!)
        self.detailsUrl = detailsUrl == nil ? nil : URL(string: detailsUrl!)
    }
}
