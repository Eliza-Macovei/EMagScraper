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

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (_ data:Data?,_ response:URLResponse?,_ error:Error?) -> Swift.Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (self.dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class HtmlReader: HtmlReaderProtocol {
    
    var session: URLSessionProtocol?
    
    init() {
        self.session = URLSession.shared
    }
    
    convenience init(session: URLSessionProtocol) {
        self.init()
        
        self.session = session
    }

    func getHtml(url: URL, completion: @escaping ((_ data: String?) -> Void)) {
        session?.dataTask(with: url, completionHandler: {
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
