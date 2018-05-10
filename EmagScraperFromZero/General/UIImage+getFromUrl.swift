//
//  UIImage+getFromUrl.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 07/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func getFromUrl(_ url: URL, with completion:@escaping (Data?, URLResponse?, Error?) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
