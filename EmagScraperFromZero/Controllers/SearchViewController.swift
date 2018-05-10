//
//  ViewController.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 03/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController
    , UITextFieldDelegate
{
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var activitySearching: UIActivityIndicatorView!
    
    // MARK: - page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activitySearching.hidesWhenStopped = true
        setButtonState(false)
    }
    
    // MARK: - Events
    @IBAction func textEditing(_ sender: UITextField) {
        let hasText = sender.text != nil && !(sender.text!.isEmpty)
        setButtonState(hasText)
    }
    
    private func setButtonState(_ isEnabled: Bool) {
        // if no value change, do nothing.
        if btnSearch.isEnabled != isEnabled {
            btnSearch.isEnabled = isEnabled
            btnSearch.backgroundColor = isEnabled ? UIColor.blue : UIColor.gray
        }
    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        activitySearching.startAnimating()
        setButtonState(false)
        txtSearch.isEnabled = false
        // check the input string: if empty/nil, we're not transitioning.
        if let searchString = txtSearch.text {
            DispatchQueue.global().async {
                let screenScraper = EmagScraper.instance
                // search for results.
                let results = screenScraper.search(searchString)
                DispatchQueue.main.async {
                    self.callbackSearch(results)
                }
            }
        } else {
            // how did you even get here?
            print("Seach Button > onclick: no action taken, search string was empty ")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        setButtonState(true)
        activitySearching.stopAnimating()
        txtSearch.isEnabled = true
        if segue.destination is ItemTableViewController {
            let tableVC = segue.destination as! ItemTableViewController
            tableVC.items = res
        } else { print("segue destination is not an Item TableView; skipping preparations...") }
    }

    private var res = [PreviewItem]()
    private func callbackSearch(_ results: [PreviewItem]) {
        if results.count == 0 {
            // if 0 results: show a popup, don't go anywhere.
            let alert = UIAlertController(title: "No results", message: textErrorMessage(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Dismiss alert"),
                                          style: .default,
                                          handler: nil
            ))
            self.present(alert, animated: true, completion: nil)
        } else {
            //if any: set in context, segue to the Master.
            res = results
            self.performSegue(withIdentifier: "toTableView", sender: self)
        }
    }
    
    // MARK: -
    
    // TODO: E.M: look up *actual* field validation, and not this ad-hoc silliness.
    private func textErrorMessage() -> String {
        if let searchString = txtSearch.text {
            return "No results found for search string '\(searchString)'"
        } else { return "Search string was empty" }
        
    }
}

