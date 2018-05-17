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
    var model: DetailsItem? {
        didSet {
            setValues(model!)
        }
    }

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtSpecifications: UILabel!
    @IBOutlet weak var txtAvailability: UILabel!
    @IBOutlet weak var txtShipping: UILabel!
    @IBOutlet weak var txtSupplier: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    
    private var activityIndicatorView: UIActivityIndicatorView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let onTap = UITapGestureRecognizer(target: self, action: #selector(goToFirst))
        navigationItem.addButtonNav(onTap: onTap)
        
        let onTapImage = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        
        img.setupImageViewForGestureRecognizer(onTapImage)
        
        activityIndicatorView = view.generateActivityIndicator()
        activityIndicatorView?.startAnimating()
        
        resetValues()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backFromGallary",
            let pageVC = segue.destination as? PageViewController {
            pageVC.haveEmptyPage = false
            pageVC.listOfUrlsForImage = (self.model?.listOfThumbnailUrls)!
        }
    }
    
    //MARK: - update from Model.
    private func setValues(_ model: DetailsItem) {
        // this code can be called via model setter before screen elements are set; always use ?.
        
        if model.imageUrl != nil  && self.img != nil {
            self.img.loadImageUsingUrlString(url: model.imageUrl!)
        }
        
        self.txtTitle?.text = model.title
        self.txtSpecifications?.text = model.specs
        self.txtAvailability?.text = model.availability
        self.txtShipping?.text = model.shippingType
        self.txtSupplier?.text = model.seller
        self.txtSupplier?.text = model.seller
        self.txtDescription?.text = model.descr
        
        activityIndicatorView.stopAnimating()
    }
    
    private func resetValues(){
        self.img.image = nil
        
        self.txtTitle?.text = nil
        self.txtSpecifications?.text = nil
        
        self.txtAvailability?.text = nil
        self.txtShipping?.text = nil
        self.txtSupplier?.text = nil
        self.txtSupplier?.text = nil
        self.txtDescription?.text = nil
    }
}
