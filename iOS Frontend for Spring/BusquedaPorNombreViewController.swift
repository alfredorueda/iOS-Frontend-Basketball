//
//  BusquedaPorNombreViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 27/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit

class BusquedaPorNombreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfPlayers = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissAdvancedSearch(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPlayers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath)
        cell.textLabel?.text = arrayOfPlayers[indexPath.row].name!
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        performQueryToTheApi(searchText)
    }
    
    func performQueryToTheApi(searchText: String) {
        if searchText.characters.count > 0 {
            //Perform the search in the API and reload the tableView with the new data
            print(searchText)
        }
    }
}
