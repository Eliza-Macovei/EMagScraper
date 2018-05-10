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
