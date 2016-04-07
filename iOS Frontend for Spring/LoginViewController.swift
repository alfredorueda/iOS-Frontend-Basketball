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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: UIButton) {
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
                    if let jsonAsDict = JSON as? [String:AnyObject] {
                        print("Access Token: \(jsonAsDict["access_token"] as! String)")
                        print("Refresh Token: \(jsonAsDict["refresh_token"] as! String)")
                        print("Scope: \(jsonAsDict["scope"] as! String)")
                        print("Token Type: \(jsonAsDict["token_type"] as! String)")
                        print("Expires in: \(jsonAsDict["expires_in"] as! Int)")
                        
                        
                        self.defaults.setObject("\(jsonAsDict["access_token"] as! String)", forKey: "accessToken")
                        self.defaults.setObject("\(jsonAsDict["refresh_token"] as! String)", forKey: "refreshToken")
                        self.defaults.setObject("\(jsonAsDict["scope"] as! String)", forKey: "scope")
                        self.defaults.setObject("\(jsonAsDict["token_type"] as! String)", forKey: "tokenType")
                        self.defaults.setObject("\(jsonAsDict["expires_in"] as! Int)", forKey: "expiresIn")
                        
                    }
                    self.performSegueWithIdentifier("ShowUserDetails", sender: nil)
                }
            case .Failure (let error):
                print("Request failed with error: \(error)")
            }
        }
    }
}


