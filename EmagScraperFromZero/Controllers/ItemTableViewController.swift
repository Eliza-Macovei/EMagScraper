//
//  ItemTableViewController.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 04/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    // MARK: Properties
    var items = [PreviewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the 'eMag' back button; in here, its identical to the back button.
        let onTap = UITapGestureRecognizer(target: self, action: #selector(goToFirst))
        navigationItem.addButtonNav(onTap: onTap)
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    // To Details:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender != nil {
           let indexPath =  (sender as? IndexPath) ?? tableView.indexPathForSelectedRow!
           let itemModel = items[indexPath.row]
           let pageVC = segue.destination as? PageViewController
           let detailsVC = segue.destination as? DetailsViewController
            
            if pageVC != nil && itemModel.detailsItem != nil {
                pageVC?.haveEmptyPage = false
            }
            
            EmagScraper.instance.getDetails(itemModel, callbackDetails: { (detailsItem: DetailsItem?) in
                
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    if detailsVC != nil {
                        detailsVC?.model = detailsItem
                    } else if pageVC != nil {
                        pageVC?.listOfUrlsForImage = (detailsItem?.listOfThumbnailUrls)!
                    }
                })
            })
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemViewController", for: indexPath) as? ItemTableViewCell
            else { fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        /* "the above code requests a cell from the table view. Instead of creating new cells and deleting old cells as the user scrolls, the table tries to reuse the cells when possible. If no cells are available, dequeueReusableCell(withIdentifier:for:) instantiates a new one; however, as cells scroll off the scene, they are reused. The identifier tells dequeueReusableCell(withIdentifier:for:) which type of cell it should create or reuse." */
        
        // Configure the cell...
        let model = items[indexPath.row]
        cell.model = model // without thumbnail; we're filling that asynchronously.
        if model.thumbnailUrl != nil {
            cell.imgThumbnail.setupImageViewForGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        }
        
        return cell
    }
    
    
    @objc override func imageTapped(tapGestureRecognizer: UITapGestureRecognizer, sender: Any?) {
        let touch = tapGestureRecognizer.location(in: tableView)
        let cell = tableView.indexPathForRow(at: touch)
        
        super.imageTapped(tapGestureRecognizer: tapGestureRecognizer, sender: cell)
    }
}
