//
//  ScreenScraper.swift
//  EmagScraper
//
//  Created by Elizabeta Macovei on 25/04/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

//import Foundation

protocol ScreenScraper {
    
    var baseUrl: String { get }
    
    func search(_ searchRaw: String, callbackSearch: @escaping (([PreviewItem]) -> Void))
        
    func getDetails(_ item: PreviewItem, callbackDetails: @escaping ((DetailsItem?) -> Void))
}
