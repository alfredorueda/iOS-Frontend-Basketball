//
//  UserDetailsViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var accessToken: UILabel!
    @IBOutlet weak var tokenType: UILabel!
    @IBOutlet weak var grantType: UILabel!
    @IBOutlet weak var scope: UILabel!
    @IBOutlet weak var refreshToken: UILabel!
    @IBOutlet weak var expiresIn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showPlayerList(sender: UIButton) {
        performSegueWithIdentifier("ShowPlayerList", sender: nil)
    }
    
}
