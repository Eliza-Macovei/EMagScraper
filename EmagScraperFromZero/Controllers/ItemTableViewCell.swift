//
//  ItemTableViewCell.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 04/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    private var _model: PreviewItem?
    var model: PreviewItem? {
        get {
            return _model
        }
        set(newModel) {
            _model = newModel 
            if let newModel = newModel {
                setCellValues(newModel)
            } else {
                //print(" >> TableViewCell - received a nil model!")
            }
        }
    }
    
    // MARK: Properties
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtCoin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setCellValues(_ model: PreviewItem) {
        self.imgThumbnail?.image = model.thumbnail
        self.txtTitle?.text = model.title
        self.txtPrice?.text = String(format: "%.2f", (model.price + 0.0049))
        self.txtCoin?.text = model.priceCoin
    }
    
    func fillThumbnailIfEmpty() {
        if let m = model {
            if m.thumbnailUrl == nil || m.thumbnail != nil { return }
            self.imgThumbnail.image = #imageLiteral(resourceName: "missing")
            
            DispatchQueue.global().async() {
                UIImage.getFromUrl(m.thumbnailUrl!) { (data, response, error ) in
                    var thumbnail: UIImage?
                    guard let data = data, error == nil else {
                        print(error!)
                        thumbnail = #imageLiteral(resourceName: "noInternet")
                        self.updateThumbnailAsync(thumbnail)
                        return
                    }
                    thumbnail = UIImage(data: data)
                    self.updateThumbnailAsync(thumbnail)
                } // end callback to getFromUrl
            } // end asyc call on global
        }
    } // else, model is nil; lolwut?
    
    private func updateThumbnailAsync(_ thumbnail: UIImage?) {
        DispatchQueue.main.async() {
            self.updateThumbnail(thumbnail)
        }
    }
    private func updateThumbnail(_ thumbnail: UIImage?) {
        self.model?.thumbnail = thumbnail
        self.imgThumbnail.image = thumbnail
    }
}
