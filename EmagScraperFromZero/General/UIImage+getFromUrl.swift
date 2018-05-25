//
//  UIImage+getFromUrl.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 07/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageUsingUrlString(urlString: String, _ session: URLSessionProtocol? = URLSession.shared) {
        loadImageUsingUrlString(url: URL(string: urlString)!, session)
    }    
    
    func loadImageUsingUrlString(url: URL, _ session: URLSessionProtocol? = URLSession.shared) {
        
        self.image = nil
        
        if let imageFromCache = ImageCache.sharedCache.object(forKey: url.absoluteURL as AnyObject) {
            self.image = imageFromCache as? UIImage
            return
        }
        
        session?.dataTask(with: url, completionHandler: {
            (data, response, error) in

            if error != nil {
                print(error ?? "")

                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in

                let imageToCache = UIImage(data: data!)

                if imageToCache != nil {
                    ImageCache.sharedCache.setObject(imageToCache!, forKey: url.absoluteURL as AnyObject, cost: (data?.count)!)
                }
                
                self?.image = imageToCache
            })

        }).resume()
    }
    
    public func setupImageViewForGestureRecognizer(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
}
