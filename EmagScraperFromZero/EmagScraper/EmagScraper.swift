//
//  EmagScraper.swift
//  EmagScraper
//
//  Created by Elizabeta Macovei on 25/04/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation

// TODO: a factory for scraper.
class EmagScraper : ScreenScraper {
        
    static let instance = EmagScraper()
    private init() { }
    
    private(set) var baseUrl: String = "https://m.emag.ro/search/"
    
    func search(_ searchRaw: String, callbackSearch: @escaping (([PreviewItem]) -> Void)) {
        
        if searchRaw.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) != nil {
            // append to baseUrl; not using a pre-made URL because appendingPathComponent is mutating.
            let url = URL(string: baseUrl)!.appendingPathComponent(searchRaw)
            
            EmagItemParser().parse(url: url, completion: { (items: [PreviewItem]) in
                print("...done; returning \(items.count) items.")
                callbackSearch(items)
            })
        } else {
            // what excuse of an URL did you hand me?
            print("could not encode desired search string '\(searchRaw)' as an URL fragment")
        }
    }
    
    // for a given item, return the details.
    func getDetails(_ item: PreviewItem, callbackDetails: @escaping ((DetailsItem?) -> Void)) {
        // from item, build the URL that returns the details.
        if let url = item.detailsUrl, item.detailsItem == nil {
            EMagDetailsParser().parse(url: url, completion: { (detailsItem: DetailsItem?) in
                detailsItem?.previewItem = item
                item.detailsItem = detailsItem
                
                callbackDetails(item.detailsItem)
            })
        } else {
            callbackDetails(item.detailsItem)
        }
    }
}
