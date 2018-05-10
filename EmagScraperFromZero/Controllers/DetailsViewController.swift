//
//  DetailsViewController.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 04/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Properties
    private var _model: DetailsItem?
    var model: DetailsItem? {
        get {
            return _model
        }
        set(newModel) {
            _model = newModel 
            if let newModel = newModel {
                setValues(newModel)
            } else {
                print(" >> DetailsViewController - received a nil model!")
            }
        }
        ////  didSet(newModel) - newModel is eternally nil. Especially when the value was not nil.
    }

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtSpecifications: UILabel!
    @IBOutlet weak var txtAvailability: UILabel!
    @IBOutlet weak var txtShipping: UILabel!
    @IBOutlet weak var txtSupplier: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let onTap = UITapGestureRecognizer(target: self, action: #selector(goToFirst))
        navigationItem.addButtonNav(onTap: onTap)
        
        if model != nil{
            // TODO: move Image retrieval in Model. In table cells it makes sense, because they aren't all visible, but here it needs to be retrieved ASAP.
            fetchImageIfEmpty()
            setValues(model!)
        } else { print("Details >> Load has found an empty Model; did you forget to set it, or is it set later (unlikely)?") }
        
    }
    
    private func fetchImageIfEmpty() {
        print(" >> getting image for Details.")
        if let m = _model {
            
            if m.imageUrl == nil {
                updateImage(#imageLiteral(resourceName: "missing"))
                return
            }
            if m.image != nil {
                updateImage(m.image)
                return
            }
            
            var img: UIImage?
            DispatchQueue.global().async() {
                UIImage.getFromUrl(m.imageUrl!) { (data, response, error ) in
                    guard let data = data, error == nil else {
                        print(error!)
                        img = #imageLiteral(resourceName: "noInternet")
                        self.updateImageAsync(img)
                        return
                    }
                    img = UIImage(data: data)
                    self.updateImageAsync(img)
                } // end callback to getFromUrl
            } // end ASYNC call on global
        } // else, model is nil; lolwut?
    }
    
    private func updateImageAsync(_ img: UIImage?) {
        DispatchQueue.main.async() {
            print(" >> got image for Details.")
            self.updateImage(img)
        }
    }
    private func updateImage(_ image: UIImage?) {
        self.model?.image = image
        self.img.image = image
    }
    

    // MARK: - Navigation
    @objc private func goToFirst()
    {
        if let nc = navigationController {
            nc.popToRootViewController(animated: true)
        } else { print ("No nav controller is found") }
    }

    //MARK: - update from Model.
    private func setValues(_ model: DetailsItem) {
        // this code can be called via model setter before screen elements are set; always use ?.
        self.txtTitle?.text = model.title
        //self.img?.image = model.image
        self.txtSpecifications?.text = model.specs
        
        self.txtAvailability?.text = model.availability
        self.txtShipping?.text = model.shippingType
        self.txtSupplier?.text = model.seller
        
        // ? no Price reminder, bit weird ?
        
        self.txtSupplier?.text = model.seller
        self.txtDescription?.text = model.descr
        
    }
}
