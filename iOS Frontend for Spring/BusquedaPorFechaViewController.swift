//
//  BuesquedaPorFechaViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 05/05/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class BusquedaPorFechaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fechaInicioTextField: UITextField!
    @IBOutlet weak var fechaFinaltextField: UITextField!
    
    var arrayOfPlayers = [Player]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func hideAdvancedSearch(sender: UIBarButtonItem) {
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
        performSegueWithIdentifier("showDetailsFromFechaSearch", sender: self)
    }
    
    @IBAction func performSearch(sender: UIButton) {
        
        let fechaInicio = fechaInicioTextField.text
        let fechaFinal = fechaFinaltextField.text
        
        let headersRequest = ["Authorization" : "Bearer \((defaults.objectForKey("accessToken") as! String))"]
        
        if let _ = fechaInicio {
            if let _ = fechaFinal {
                Alamofire.request(.GET, "http://\(Helper().serverIP)/api/players/canastas/between/\(fechaInicio!)/and/\(fechaFinal!)", headers: headersRequest).responseJSON{ response in
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsFromFechaSearch" {
            let vc = segue.destinationViewController as! PlayerDetailsViewController
            let index = tableView.indexPathForSelectedRow!
            vc.player = arrayOfPlayers[index.row]
        }
    }

}
