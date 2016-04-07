//
//  ViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: UIButton) {
        //let stringToBeEncoded = "username=admin&password=admin&grant_type=password&scope=read%20write&client_secret=mySecretOAuthSecret&client_id=basketballapp"
        //print(stringToBeEncoded.toBase64())
        
        let bodyHTTP = ["username"      : "\(usernameText.text!)",
                        "password"      : "\(passwordText.text!)",
                        "grant_type"    : "password",
                        "scope"         : "read write",
                        "client_secret" : "mySecretOAuthSecret",
                        "client_id"     : "basketballapp"]
        let headersRequest = ["Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, "http://172.16.155.36:8080/oauth/token", parameters: bodyHTTP, headers: headersRequest).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let _ = JSON["error"]! {
                    print(JSON["error"])
                } else {
                    print(JSON)
                    self.performSegueWithIdentifier("ShowUserDetails", sender: nil)
                }
            case .Failure (let error):
                print("Request failed with error: \(error)")
            }
        }
    }
}


