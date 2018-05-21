//
//  Url+getHtml.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 08/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation

protocol HtmlReaderProtocol {
    func getHtml(url: URL, completion: @escaping ((_ data: String?) -> Void))
}

class HtmlReader: HtmlReaderProtocol {
    
    func getHtml(url: URL, completion: @escaping ((_ data: String?) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in

            if error != nil {
                print(error!)
                return
            }

            let html = String(data: data!, encoding: .utf8)

            completion(html)
        }).resume()
    }
}
