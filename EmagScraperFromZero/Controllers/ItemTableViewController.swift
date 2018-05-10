//
//  ItemTableViewController.swift
//  EmagScraperFromZero
//
//  Created by Elizabeta Macovei on 04/05/2018.
//  Copyright © 2018 Elizabeta Macovei. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var items = [PreviewItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the 'eMag' back button; in here, its identical to the back button.
        let onTap = UITapGestureRecognizer(target: self, action: #selector(goToFirst))
        navigationItem.addButtonNav(onTap: onTap)
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Navigation
    // to Search:
    @objc private func goToFirst() {
        if let nc = navigationController {
            nc.popToRootViewController(animated: true)
        } else { print ("No nav controller is found") }
    }

    // To Details:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailsViewController {
            let detailsVC = segue.destination as! DetailsViewController
            if  let rowView = sender as? ItemTableViewCell {
                let id = rowView.txtTitle.text
                if let itemModel = items.first(where: {m in m.title == id}) {
                    detailsVC.model = EmagScraper.instance.getDetails(itemModel)
                } else {
                    print ("cannot locate row model for details navigation")
                }
            }
        } else { print("SEGUE: destination is not a DetailsViewController") }
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

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  cell is ItemTableViewCell {
            let itemCell = cell as! ItemTableViewCell
            itemCell.fillThumbnailIfEmpty()
        }
    }
}
