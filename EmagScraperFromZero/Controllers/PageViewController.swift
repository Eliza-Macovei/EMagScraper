//
//  PageViewController.swift
//  TestBackButton1.0
//
//  Created by Pinzariu Marian on 10/05/2018.
//  Copyright © 2018 Pinzariu Marian. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: Properties
    var listOfUrlsForImage: [URL?] = [] {
        didSet {
            updateUI()
        }
    }
    
    var haveEmptyPage: Bool = true {
        didSet {
            if haveEmptyPage != oldValue && haveEmptyPage == true {
                setEmptyPage()
            } else {
                activityIndicatorView?.stopAnimating()
            }
        }
    }
    
    private var dataSourceVC: [ImageViewController] = []
    private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let instanceOfImageViewControllerID = "ImageViewControllerID"
    private let uiStoryboardName = "Main"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        activityIndicatorView = self.view.generateActivityIndicator()
        
        if haveEmptyPage {
            setEmptyPage()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = dataSourceVC.index(of: viewController as! ImageViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return dataSourceVC.last
        }
        
        guard dataSourceVC.count > previousIndex else {
            return nil
        }
        
        return dataSourceVC[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = dataSourceVC.index(of: viewController as! ImageViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < dataSourceVC.count else {
            return dataSourceVC.first
        }
        
        guard dataSourceVC.count > nextIndex else {
            return nil
        }
        
        return dataSourceVC[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSourceVC.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = dataSourceVC.index(of: firstViewController as! ImageViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    private func setEmptyPage() {
        activityIndicatorView?.startAnimating()
        
        let emty = getViewControllerInstance(name: instanceOfImageViewControllerID) as? ImageViewController
        emty?.imageView = UIImageView(image: nil)
        self.setViewControllers([emty!], direction: .forward, animated: true, completion: nil)
    }
    
    private func updateUI() {
        self.dataSourceVC = self.generateVC(number: self.listOfUrlsForImage.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            if let firstVC = self?.dataSourceVC.first {
                self?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
            
            if self?.activityIndicatorView != nil {
                self?.activityIndicatorView.stopAnimating()
            }
        })
    }
    
    private func generateVC(number: Int) -> [ImageViewController] {
        var controls: [ImageViewController] = []
        
        for i in 0..<number {
            guard let url = listOfUrlsForImage[i],
                  let newUIVC = getViewControllerInstance(name: instanceOfImageViewControllerID) as? ImageViewController else {
                continue
            }
            
            newUIVC.view.backgroundColor? = .clear
            newUIVC.imageView!.loadImageUsingUrlString(url: url)
            controls.append(newUIVC)
        }
        
        return controls
    }
    
    private func getViewControllerInstance(name: String) -> UIViewController {
        return UIStoryboard(name: uiStoryboardName, bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
