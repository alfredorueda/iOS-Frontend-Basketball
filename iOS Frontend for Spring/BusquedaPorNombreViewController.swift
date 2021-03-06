//
//  BusquedaPorNombreViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 27/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class BusquedaPorNombreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfPlayers = [Player]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDetailsFromNombreSearch", sender: self)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        performQueryToTheApi(searchText)
    }
    
    func performQueryToTheApi(searchText: String) {
        if searchText.characters.count > 0 {
            //Perform the search in the API and reload the tableView with the new data
            let nombre = searchText
                
            let headersRequest = ["Authorization" : "Bearer \((defaults.objectForKey("accessToken") as! String))"]
            
            Alamofire.request(.GET, "http://\(Helper().serverIP)/api/players/nombre/\(nombre)", headers: headersRequest).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    print(JSON)
                    if let dictionaryJson = JSON as? [[String:AnyObject]]{
                        self.arrayOfPlayers = []
                        for player in dictionaryJson {
                            self.arrayOfPlayers.append(Player(dictionary: player)!)
                        }
                    }
                    self.tableView.reloadData()
                    
                case .Failure (let error):
                    print("Request failed with error: \(error)")
                }
            }

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsFromNombreSearch" {
            let vc = segue.destinationViewController as! PlayerDetailsViewController
            let index = tableView.indexPathForSelectedRow!
            vc.player = arrayOfPlayers[index.row]
        }
    }
    
}
