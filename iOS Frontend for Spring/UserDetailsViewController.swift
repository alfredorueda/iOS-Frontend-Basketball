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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showPlayerList(sender: UIButton) {
        performSegueWithIdentifier("ShowPlayerList", sender: nil)
    }
    
}
