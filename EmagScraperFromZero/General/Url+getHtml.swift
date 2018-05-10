//
//  Url+getHtml.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 08/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation

class HtmlReader {
    
    private let htmlSemaphore = DispatchSemaphore(value: 0)
    
    func getHtml(url: URL) -> String {
        var html: String = ""
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard
                let data = data,
                error == nil,
                let document = String(data: data, encoding: .utf8)
                else {
                    print ("parsing task failed.")
                    return
            }
            html = document
            
            defer { self.htmlSemaphore.signal() }
        }
        task.resume()
        htmlSemaphore.wait()
        return html
    }
}
