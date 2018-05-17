//
//  Navigation+ToSearch.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 05/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    func addButtonNav(onTap: UITapGestureRecognizer) {
        let imgEmagNav = UIImageView(image: #imageLiteral(resourceName: "emagLogo"))
        imgEmagNav.contentMode = .scaleAspectFit
        imgEmagNav.isUserInteractionEnabled = true
        imgEmagNav.addGestureRecognizer(onTap)
        let btnWrapper = UIBarButtonItem(customView: imgEmagNav)

        btnWrapper.style = .done
        
        self.rightBarButtonItems = [btnWrapper]
    }
}

extension UIView {
    public func generateActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = #colorLiteral(red: 0.4078431373, green: 0.09411764706, blue: 0.5333333333, alpha: 1)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = self.center
        
        self.addSubview(activityIndicatorView)
        
        return activityIndicatorView
    }
}

extension UIViewController {

    @objc func goToFirst() {
        if let nc = navigationController {
            nc.popToRootViewController(animated: true)
        } else { print ("No nav controller is found") }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer, sender: Any?) {        
        self.performSegue(withIdentifier: "backFromGallary", sender: sender)
    }
}

extension UIImageView {
    func loadImageUsingUrlString(urlString: String) {
        loadImageUsingUrlString(url: URL(string: urlString)!)
    }
    
    func loadImageUsingUrlString(url: URL) {
        
        self.image = nil

        if let imageFromCache = ImageCache.sharedCache.object(forKey: url.absoluteURL as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error ?? "")
                self.image = #imageLiteral(resourceName: "noInternet")

                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
                
                let imageToCache = UIImage(data: data!)
                
                ImageCache.sharedCache.setObject(imageToCache!, forKey: url.absoluteURL as AnyObject, cost: (data?.count)!)
                
                self?.image = imageToCache
            })
            
        }).resume()
    }
    
    public func setupImageViewForGestureRecognizer(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
