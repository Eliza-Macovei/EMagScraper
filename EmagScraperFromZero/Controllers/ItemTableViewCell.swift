//
//  ItemTableViewCell.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 04/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var model: PreviewItem? {
        didSet {
            if model != nil {
                setCellValues(model!)
            }
        }
    }
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtCoin: UILabel!

    private func setCellValues(_ model: PreviewItem) {
        if model.thumbnailUrl != nil {
            self.imgThumbnail?.loadImageUsingUrlString(url: model.thumbnailUrl!)
        } else {
            self.imgThumbnail?.image = #imageLiteral(resourceName: "missing")
        }
        
        self.txtTitle?.text = model.title
        self.txtPrice?.text = String(format: "%.2f", (model.price + 0.0049))
        self.txtCoin?.text = model.priceCoin
    }
}
