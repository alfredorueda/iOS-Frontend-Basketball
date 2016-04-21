//
//  PlayerListViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class PlayerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfPlayers = [Player]()
    let defaults = NSUserDefaults.standardUserDefaults()
    var refreshControl: UIRefreshControl!
    
    override func viewDidAppear(animated: Bool) {
        fetchDataFromTheApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromTheApi()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(PlayerListViewController.reloadTableView(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPlayers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayersCell", forIndexPath: indexPath) as! PlayersCell
        cell.playerId.text = String(arrayOfPlayers[indexPath.row].id!)
        cell.playerName.text = arrayOfPlayers[indexPath.row].name!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("PlayerDetails", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func reloadTableView(sender: AnyObject) {
        fetchDataFromTheApi()
    }
    
    func fetchDataFromTheApi() {
        let headersRequest = ["Authorization" : "Bearer \((defaults.objectForKey("accessToken") as! String))"]
        print(headersRequest)
        
        Alamofire.request(.GET, "http://172.16.155.36:8080/api/players", headers: headersRequest).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let dictionaryJson = JSON as? [[String:AnyObject]]{
                    print(dictionaryJson)
                    self.arrayOfPlayers = []
                    for player in dictionaryJson {
                        self.arrayOfPlayers.append(Player(dictionary: player)!)
                    }
                    self.refreshControl.endRefreshing()
                }
                self.tableView.reloadData()
                
            case .Failure (let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayerDetails" {
            let vc = segue.destinationViewController as! PlayerDetailsViewController
            let index = sender as! NSIndexPath
            vc.player = arrayOfPlayers[index.row]
        }
    }
}
