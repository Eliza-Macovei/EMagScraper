//
//  ImageViewController.swift
//  TestBackButton1.0
//
//  Created by Pinzariu Marian on 10/05/2018.
//  Copyright © 2018 Pinzariu Marian. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView! = UIImageView(image: UIImage.from(color: .white))
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetZoomScale()
        scrollView.delegate = self
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        if !(navigationController?.isNavigationBarHidden)! {
            resetZoomScale()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @objc private func resetZoomScale() {
        scrollView.zoomScale = 1.0
    }
}
